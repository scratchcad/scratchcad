//! Worker processes: every job runs in a fresh `scratchcad worker` process.
//!
//! Not every OpenCASCADE operation can be interrupted (fillets, chamfers,
//! lofts and sweeps run to completion once started), and native code that
//! crashes or allocates without bound would take the server down with it.
//! A process can simply be killed: [`Jobs`](crate::jobs::Jobs) kills the
//! worker when the job runs out of time or its client goes away, and the
//! limits the worker sets on itself stop it using more CPU time or memory
//! than the configuration allows.
//!
//! The protocol, over the worker's standard streams:
//! - the server writes one JSON [`Request`] to its stdin and closes it;
//! - the worker writes frames to its stdout: `[STAGE, stage]` whenever the
//!   job moves on to a new [`Stage`], so that a timeout can say what ran out
//!   of time, then one result: `RESULT`, a little-endian `u32` length and the
//!   JSON of `Result<meta, ApiError>`, then a `u64` length and the body (a
//!   PNG or an exported file);
//! - anything else it prints, OpenCASCADE's messages among it, goes to its
//!   stderr, which the server logs.

use std::{
    cell::Cell,
    fs::File,
    io::{self, BufWriter, Read, Write},
};

use rustix::process::{Resource, Rlimit, getrlimit, setrlimit};
use scratchcad_occt_rhai::{MessageLevel, set_message_handler};
use serde::{Deserialize, Serialize};

use crate::{
    api::{ExportRequest, Raster2dRequest, Raster3dRequest, ValidateRequest},
    config::Config,
    error::ApiError,
    export::ExportFormat,
    jobs::{self, Stage},
    script::ScriptLimits,
};

/// Frame tag: the job moved on to the stage in the next byte
pub const STAGE: u8 = b'S';
/// Frame tag: the job's result follows
pub const RESULT: u8 = b'R';

/// The limits a job runs under
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Settings {
    pub script: ScriptLimits,
    pub max_faces: usize,
    pub max_mesh_triangles: usize,
    pub max_export_bytes: usize,
    pub memory_mib: u64,
    pub cpu_seconds: u64,
}

impl Settings {
    pub fn new(config: &Config) -> Self {
        Self {
            script: ScriptLimits {
                max_operations: config.max_script_operations,
                max_string_size: config.max_script_bytes,
            },
            max_faces: config.max_faces,
            max_mesh_triangles: config.max_mesh_triangles,
            max_export_bytes: config.max_export_bytes,
            memory_mib: config.worker_memory_mib,
            cpu_seconds: config.worker_cpu_seconds,
        }
    }
}

/// What the server asks a worker to do
#[derive(Serialize, Deserialize)]
pub struct Request {
    pub settings: Settings,
    pub job: Job,
}

#[derive(Serialize, Deserialize)]
pub enum Job {
    Validate(ValidateRequest),
    Raster2d(Raster2dRequest),
    Raster3d(Raster3dRequest),
    Export(ExportFormat, ExportRequest),
}

/// A finished job: metadata for the response, and its body
pub struct Output {
    pub meta: serde_json::Value,
    pub body: Vec<u8>,
}

impl Output {
    pub fn new(meta: &impl Serialize, body: Vec<u8>) -> Result<Self, ApiError> {
        let meta = serde_json::to_value(meta)
            .map_err(|e| ApiError::Internal(format!("encoding a job's result: {e}")))?;
        Ok(Self { meta, body })
    }
}

/// Context handed to a running job
pub struct JobCtx {
    pub settings: Settings,
    stage: Cell<Stage>,
    out: File,
}

impl JobCtx {
    /// Records what the job is doing, and tells the server; jobs start in
    /// [`Stage::Script`]
    pub fn set_stage(&self, stage: Stage) {
        self.stage.set(stage);
        // If the server has gone, the worker is about to be killed anyway.
        let _ = (&self.out).write_all(&[STAGE, stage as u8]);
    }
}

/// `scratchcad worker`: runs the job the server writes to stdin
pub fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Results go to the real stdout. From here on, anything else written to
    // stdout (by OpenCASCADE, say) goes to stderr instead.
    let out = File::from(rustix::io::dup(io::stdout())?);
    rustix::stdio::dup2_stdout(io::stderr())?;
    // Die with the server, should it die first.
    #[cfg(target_os = "linux")]
    rustix::process::set_parent_process_death_signal(Some(rustix::process::Signal::KILL))?;
    set_message_handler(MessageLevel::Warning, log_occt_message);

    let mut input = vec![];
    io::stdin().read_to_end(&mut input)?;
    let Request { settings, job } = serde_json::from_slice(&input)?;
    limit_resources(&settings)?;

    let ctx = JobCtx {
        settings,
        stage: Cell::new(Stage::Script),
        out,
    };
    let result = run(job, &ctx);
    write_result(&ctx.out, result)?;
    Ok(())
}

fn run(job: Job, ctx: &JobCtx) -> Result<Output, ApiError> {
    let result = match job {
        Job::Validate(req) => req.run(ctx),
        Job::Raster2d(req) => req.run(ctx),
        Job::Raster3d(req) => req.run(ctx),
        Job::Export(format, req) => req.run(format, ctx),
    };
    // OpenCASCADE reports a failed allocation as an error, like any other.
    result.map_err(|e| {
        if jobs::is_out_of_memory(&e.to_string()) {
            jobs::memory_exceeded(ctx.stage.get(), ctx.settings.memory_mib)
        } else {
            e
        }
    })
}

/// Caps the worker's memory and CPU time, and turns off core dumps; it can
/// lower these limits but never raise them again.
fn limit_resources(settings: &Settings) -> rustix::io::Result<()> {
    let limit = |resource, soft: u64, hard: u64| {
        // Never above a limit the server itself runs under
        let ceiling = getrlimit(resource).maximum.unwrap_or(u64::MAX);
        setrlimit(
            resource,
            Rlimit {
                current: Some(soft.min(ceiling)),
                maximum: Some(hard.min(ceiling)),
            },
        )
    };
    limit(Resource::Core, 0, 0)?;
    // The heap and other private memory, but not the stack: under a limit
    // on all address space, a full one fails the next stack page, and the
    // worker dies of a segfault instead of a failed allocation.
    let bytes = settings.memory_mib.saturating_mul(1 << 20);
    limit(Resource::Data, bytes, bytes)?;
    // SIGXCPU at the soft limit says why the worker died; SIGKILL follows a
    // second later should it survive that.
    let cpu = settings.cpu_seconds;
    limit(Resource::Cpu, cpu, cpu.saturating_add(1))
}

/// Writes one of OpenCASCADE's messages (warnings and worse) to stderr, as
/// a line the server logs under the `occt` target
fn log_occt_message(level: MessageLevel, text: &str) {
    let level = if level == MessageLevel::Fail {
        "fail"
    } else {
        "warning"
    };
    eprintln!("occt {level}: {}", text.trim().replace('\n', " "));
}

fn write_result(out: &File, result: Result<Output, ApiError>) -> io::Result<()> {
    let (meta, body) = match result {
        Ok(Output { meta, body }) => (Ok(meta), body),
        Err(e) => (Err(e), vec![]),
    };
    let header = serde_json::to_vec(&meta)?;
    let mut w = BufWriter::new(out);
    w.write_all(&[RESULT])?;
    w.write_all(
        &u32::try_from(header.len())
            .map_err(io::Error::other)?
            .to_le_bytes(),
    )?;
    w.write_all(&header)?;
    w.write_all(&(body.len() as u64).to_le_bytes())?;
    w.write_all(&body)?;
    w.flush()
}
