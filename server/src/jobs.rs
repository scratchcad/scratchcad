//! Running jobs in worker processes.
//!
//! Every job:
//! - waits (bounded by the queue timeout) for one of a fixed number of slots,
//!   returning 503 if none frees up;
//! - runs in a fresh worker process (see [`worker`](crate::worker)) that
//!   limits its own CPU time and memory;
//! - is killed when it exceeds the job budget or its client disconnects (the
//!   request future is dropped), and holds its slot until the process has
//!   exited, so abandoned work never oversubscribes the CPU.
//!
//! OpenCASCADE runs only in workers: shapes never reach the server, which
//! gets bytes and plain data back.

use std::{
    ffi::OsString,
    io,
    os::unix::process::ExitStatusExt,
    path::PathBuf,
    process::{ExitStatus, Stdio},
    sync::Arc,
    time::Duration,
};

use rustix::process::Signal;
use serde::de::DeserializeOwned;
use tokio::{
    io::{AsyncBufReadExt, AsyncRead, AsyncReadExt, AsyncWriteExt, BufReader},
    process::{Child, ChildStderr, Command},
    sync::{Semaphore, oneshot},
};
use tracing::Instrument;

use crate::{
    config::Config,
    error::ApiError,
    worker::{Job, RESULT, Request, STAGE, Settings},
};

/// What a job is doing, so that a timeout can say what ran out of time
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(u8)]
pub enum Stage {
    Script,
    Measuring,
    Meshing,
    Rendering,
    Exporting,
}

impl Stage {
    const ALL: [Stage; 5] = [
        Stage::Script,
        Stage::Measuring,
        Stage::Meshing,
        Stage::Rendering,
        Stage::Exporting,
    ];

    fn describe(self) -> &'static str {
        match self {
            Stage::Script => "running the script",
            Stage::Measuring => "measuring the shape",
            Stage::Meshing => "meshing",
            Stage::Rendering => "rendering",
            Stage::Exporting => "exporting",
        }
    }
}

/// What a worker that ran out of memory prints, or fails with: Rust's
/// allocation failure, C++'s and OpenCASCADE's
const OUT_OF_MEMORY: [&str; 3] = [
    "memory allocation of",
    "std::bad_alloc",
    "Standard_OutOfMemory",
];

/// Whether a worker's output or error says it ran out of memory
pub(crate) fn is_out_of_memory(text: &str) -> bool {
    OUT_OF_MEMORY.iter().any(|m| text.contains(m))
}

pub(crate) fn memory_exceeded(stage: Stage, mib: u64) -> ApiError {
    ApiError::LimitExceeded(format!(
        "{} needed more than the worker's {mib} MiB of memory \
         (simplify the shape, or use a coarser tolerance or a smaller image)",
        stage.describe()
    ))
}

/// Lines of a worker's stderr logged per job; the rest are dropped
const MAX_LOG_LINES: usize = 100;
/// Longer lines of a worker's stderr are split
const MAX_LOG_LINE: u64 = 4096;
/// The JSON half of a worker's result is small: messages and numbers
const MAX_HEADER_BYTES: u32 = 1 << 20;

/// How to start a worker
#[derive(Debug, Clone)]
pub struct Worker {
    program: PathBuf,
    args: Vec<OsString>,
}

impl Worker {
    /// The `worker` subcommand of the scratchcad binary at `program`
    pub fn at(program: impl Into<PathBuf>) -> Self {
        Self {
            program: program.into(),
            args: vec!["worker".into()],
        }
    }

    /// The `worker` subcommand of this binary
    pub fn current_exe() -> io::Result<Self> {
        Ok(Self::at(std::env::current_exe()?))
    }

    fn spawn(&self) -> io::Result<Child> {
        let mut command = Command::new(&self.program);
        command
            .args(&self.args)
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .kill_on_drop(true);
        // Workers get their settings over stdin. Keep the server's own,
        // the API token among them, out of their environment.
        for (key, _) in std::env::vars_os() {
            if key.as_encoded_bytes().starts_with(b"SCRATCHCAD_") {
                command.env_remove(key);
            }
        }
        command.spawn()
    }
}

/// What a supervisor needs to run one job
#[derive(Clone)]
struct Limits {
    budget: Duration,
    memory_mib: u64,
    cpu_seconds: u64,
    max_reply_bytes: u64,
}

/// A worker's result, still encoded: the JSON of `Result<meta, ApiError>`,
/// and the body
struct Reply {
    header: Vec<u8>,
    body: Vec<u8>,
}

pub struct Jobs {
    slots: Arc<Semaphore>,
    max_slots: usize,
    queue_timeout: Duration,
    worker: Worker,
    settings: Settings,
    limits: Limits,
}

impl Jobs {
    pub fn new(config: &Config, worker: Worker) -> Self {
        // The largest body a worker may send back: an export, or a PNG, which
        // is never much bigger than its raw RGBA pixels.
        let side = u64::from(config.max_image_size_2d.max(config.max_image_size_3d));
        let png = 5 * side * side;
        Self {
            slots: Arc::new(Semaphore::new(config.max_concurrent_jobs)),
            max_slots: config.max_concurrent_jobs,
            queue_timeout: config.queue_timeout(),
            worker,
            settings: Settings::new(config),
            limits: Limits {
                budget: config.job_timeout(),
                memory_mib: config.worker_memory_mib,
                cpu_seconds: config.worker_cpu_seconds,
                max_reply_bytes: (config.max_export_bytes as u64).max(png) + (1 << 20),
            },
        }
    }

    /// Number of jobs currently executing
    pub fn active(&self) -> usize {
        self.max_slots - self.slots.available_permits()
    }

    pub fn capacity(&self) -> usize {
        self.max_slots
    }

    /// Stops accepting new jobs (used during shutdown)
    pub fn close(&self) {
        self.slots.close();
    }

    /// Runs a job in a worker, returning its metadata and body
    pub async fn run<M: DeserializeOwned>(&self, job: Job) -> Result<(M, Vec<u8>), ApiError> {
        let permit = tokio::time::timeout(self.queue_timeout, self.slots.clone().acquire_owned())
            .await
            .map_err(|_| ApiError::Overloaded)?
            .map_err(|_| ApiError::Overloaded)?; // semaphore closed: shutting down
        let request = Request {
            settings: self.settings.clone(),
            job,
        };
        let request = serde_json::to_vec(&request)
            .map_err(|e| ApiError::Internal(format!("encoding a job: {e}")))?;

        // The supervisor owns the worker and the slot. When this future is
        // dropped (the client went away), it kills the worker, waits for it
        // to exit, and only then frees the slot.
        let (tx, rx) = oneshot::channel();
        let (worker, limits) = (self.worker.clone(), self.limits.clone());
        tokio::spawn(
            async move {
                let _permit = permit;
                supervise(&worker, &request, &limits, tx).await;
            }
            .in_current_span(),
        );
        let reply = rx
            .await
            .map_err(|_| ApiError::Internal("a job's supervisor stopped".into()))??;
        let meta: Result<M, ApiError> = serde_json::from_slice(&reply.header)
            .map_err(|e| ApiError::Internal(format!("decoding a worker's result: {e}")))?;
        Ok((meta?, reply.body))
    }
}

async fn supervise(
    worker: &Worker,
    request: &[u8],
    limits: &Limits,
    mut tx: oneshot::Sender<Result<Reply, ApiError>>,
) {
    let mut child = match worker.spawn() {
        Ok(child) => child,
        Err(e) => {
            let _ = tx.send(Err(ApiError::Internal(format!("starting a worker: {e}"))));
            return;
        }
    };
    let result = tokio::select! {
        result = communicate(&mut child, request, limits) => result,
        () = tx.closed() => Err(ApiError::Internal("the client went away".into())),
    };
    // However the job ended, the worker is gone before its slot frees up.
    let _ = child.start_kill();
    let _ = child.wait().await;
    let _ = tx.send(result);
}

async fn communicate(
    child: &mut Child,
    request: &[u8],
    limits: &Limits,
) -> Result<Reply, ApiError> {
    let mut stdin = child.stdin.take().expect("stdin is piped");
    let mut stdout = BufReader::new(child.stdout.take().expect("stdout is piped"));
    let stderr = child.stderr.take().expect("stderr is piped");
    let logs = tokio::spawn(log_stderr(stderr).in_current_span());

    let mut stage = Stage::Script;
    let finished = tokio::time::timeout(limits.budget, async {
        // A worker that stops reading early says why on stderr.
        let _ = stdin.write_all(request).await;
        drop(stdin);
        let reply = read_reply(&mut stdout, &mut stage, limits.max_reply_bytes).await;
        if reply.is_err() {
            // Nothing more is coming. A worker that has already exited
            // keeps the status it exited with.
            let _ = child.start_kill();
        }
        (reply, child.wait().await)
    })
    .await;
    let Ok((reply, status)) = finished else {
        return Err(ApiError::Timeout(format!(
            "{} exceeded the {} s job budget",
            stage.describe(),
            limits.budget.as_secs_f64(),
        )));
    };
    match reply {
        Ok(reply) => Ok(reply),
        // The worker exited without a result; its stderr is at an end too.
        Err(e) if e.kind() == io::ErrorKind::UnexpectedEof => {
            let out_of_memory = matches!(
                tokio::time::timeout(Duration::from_secs(1), logs).await,
                Ok(Ok(true))
            );
            Err(failed(status, out_of_memory, stage, limits))
        }
        Err(e) => Err(ApiError::Internal(format!(
            "the worker sent an invalid result while {}: {e}",
            stage.describe()
        ))),
    }
}

/// Reads stage frames until the result arrives
async fn read_reply(
    r: &mut (impl AsyncRead + Unpin),
    stage: &mut Stage,
    max_bytes: u64,
) -> io::Result<Reply> {
    let invalid = |message: String| io::Error::new(io::ErrorKind::InvalidData, message);
    loop {
        match r.read_u8().await? {
            STAGE => {
                let n = r.read_u8().await?;
                *stage = *Stage::ALL
                    .get(usize::from(n))
                    .ok_or_else(|| invalid(format!("unknown stage {n}")))?;
            }
            RESULT => {
                let len = r.read_u32_le().await?;
                if len > MAX_HEADER_BYTES {
                    return Err(invalid(format!("a {len}-byte result header")));
                }
                let header = read_exactly(r, len.into()).await?;
                let len = r.read_u64_le().await?;
                if len > max_bytes {
                    return Err(invalid(format!(
                        "a {len}-byte result; the limit is {max_bytes}"
                    )));
                }
                let body = read_exactly(r, len).await?;
                return Ok(Reply { header, body });
            }
            tag => return Err(invalid(format!("unknown frame {tag}"))),
        }
    }
}

/// Reads `len` bytes, allocating as they arrive rather than up front
async fn read_exactly(r: &mut (impl AsyncRead + Unpin), len: u64) -> io::Result<Vec<u8>> {
    let mut out = vec![];
    r.take(len).read_to_end(&mut out).await?;
    if out.len() as u64 == len {
        Ok(out)
    } else {
        Err(io::ErrorKind::UnexpectedEof.into())
    }
}

/// Why a worker exited without a result
fn failed(
    status: io::Result<ExitStatus>,
    out_of_memory: bool,
    stage: Stage,
    limits: &Limits,
) -> ApiError {
    if out_of_memory {
        return memory_exceeded(stage, limits.memory_mib);
    }
    let what = stage.describe();
    let status = match status {
        Ok(status) => status,
        Err(e) => return ApiError::Internal(format!("waiting for the worker: {e}")),
    };
    match status.signal() {
        Some(signal) if signal == Signal::XCPU.as_raw() => ApiError::LimitExceeded(format!(
            "{what} used more than the worker's {} s of CPU time \
             (simplify the shape, or use a coarser tolerance or a smaller image)",
            limits.cpu_seconds
        )),
        // OpenCASCADE doesn't always survive a failed allocation: it can
        // crash without a word.
        Some(signal) => {
            let signal = signal_name(signal);
            tracing::warn!(target: "scratchcad::worker", %signal, "the worker crashed while {what}");
            ApiError::Crashed(format!(
                "the worker crashed ({signal}) while {what}. OpenCASCADE does this when it runs \
                 out of memory (each job may use {} MiB), and on some shapes it can't handle: \
                 simplify the shape, or use a coarser tolerance or a smaller image",
                limits.memory_mib
            ))
        }
        None => ApiError::Internal(format!(
            "the worker stopped ({status}) while {what}, with no result"
        )),
    }
}

fn signal_name(signal: i32) -> String {
    [
        (Signal::SEGV, "SIGSEGV"),
        (Signal::BUS, "SIGBUS"),
        (Signal::ABORT, "SIGABRT"),
        (Signal::ILL, "SIGILL"),
        (Signal::FPE, "SIGFPE"),
        (Signal::KILL, "SIGKILL"),
    ]
    .iter()
    .find(|(s, _)| s.as_raw() == signal)
    .map_or_else(|| format!("signal {signal}"), |(_, name)| (*name).into())
}

/// Logs what a worker prints to stderr, and says whether it ran out of memory
async fn log_stderr(stderr: ChildStderr) -> bool {
    let mut reader = BufReader::new(stderr);
    let mut line = vec![];
    let (mut lines, mut out_of_memory) = (0, false);
    loop {
        line.clear();
        match (&mut reader)
            .take(MAX_LOG_LINE)
            .read_until(b'\n', &mut line)
            .await
        {
            Ok(0) | Err(_) => return out_of_memory,
            Ok(_) => {}
        }
        let text = String::from_utf8_lossy(&line);
        let text = text.trim_end();
        out_of_memory |= is_out_of_memory(text);
        lines += 1;
        if lines <= MAX_LOG_LINES {
            log_worker_line(text);
        } else if lines == MAX_LOG_LINES + 1 {
            tracing::warn!(target: "scratchcad::worker", "the worker's further output is not logged");
        }
    }
}

/// Logs a line from a worker: OpenCASCADE's messages under the `occt` target
fn log_worker_line(line: &str) {
    if let Some(message) = line.strip_prefix("occt fail: ") {
        tracing::error!(target: "occt", "{message}");
    } else if let Some(message) = line.strip_prefix("occt warning: ") {
        tracing::warn!(target: "occt", "{message}");
    } else {
        tracing::warn!(target: "scratchcad::worker", "{line}");
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use clap::Parser;

    /// Jobs run by `sh -c script`, standing in for a worker
    fn jobs(script: &str, args: &[&str]) -> Jobs {
        let config = Config::parse_from(std::iter::once("scratchcad").chain(args.iter().copied()));
        let worker = Worker {
            program: "sh".into(),
            args: vec!["-c".into(), script.into()],
        };
        Jobs::new(&config, worker)
    }

    fn job() -> Job {
        let request = serde_json::json!({ "script": "cube(1)" });
        Job::Validate(serde_json::from_value(request).unwrap())
    }

    async fn run(jobs: &Jobs) -> Result<(serde_json::Value, Vec<u8>), ApiError> {
        jobs.run(job()).await
    }

    /// A `printf` command writing a frame: a tag, the header's length and the
    /// header, then the given length bytes
    fn printf(tag: &[u8], header: &str, len: &[u8]) -> String {
        let octal = |bytes: &[u8]| {
            bytes
                .iter()
                .map(|b| format!("\\{b:03o}"))
                .collect::<String>()
        };
        let header_len = (header.len() as u32).to_le_bytes();
        format!(
            "printf '{}{}{header}{}'",
            octal(tag),
            octal(&header_len),
            octal(len)
        )
    }

    /// A worker's result, with this header and body
    fn result_frame(header: &str, body: &str) -> String {
        let len = (body.len() as u64).to_le_bytes();
        format!("{}; printf '{body}'", printf(&[RESULT], header, &len))
    }

    /// Waits for the slots to free up, for at most a second
    async fn idle(jobs: &Jobs) -> bool {
        for _ in 0..100 {
            if jobs.active() == 0 {
                return true;
            }
            tokio::time::sleep(Duration::from_millis(10)).await;
        }
        false
    }

    #[tokio::test]
    async fn results_are_decoded() {
        let worker = format!(
            "cat > /dev/null; printf 'S\\002'; {}",
            result_frame(r#"{"Ok":{"n":7}}"#, "abc")
        );
        let (meta, body) = run(&jobs(&worker, &[])).await.unwrap();
        assert_eq!(meta["n"], 7);
        assert_eq!(body, b"abc");
    }

    #[tokio::test]
    async fn errors_are_passed_through() {
        let worker = result_frame(r#"{"Err":{"Script":"oops"}}"#, "");
        let r = run(&jobs(&worker, &[])).await;
        assert!(matches!(r, Err(ApiError::Script(m)) if m == "oops"));
    }

    #[tokio::test]
    async fn timeout_kills_the_worker_and_names_the_stage() {
        let j = jobs(
            "printf 'S\\002'; exec sleep 10",
            &["--job-timeout-ms", "200"],
        );
        let r = run(&j).await;
        let Err(ApiError::Timeout(m)) = r else {
            panic!("expected a timeout, got {r:?}")
        };
        assert_eq!(m, "meshing exceeded the 0.2 s job budget");
        // The worker has exited by the time the request fails.
        assert_eq!(j.active(), 0);
    }

    #[tokio::test]
    async fn overload_returns_503() {
        let j = Arc::new(jobs(
            "exec sleep 10",
            &["--max-concurrent-jobs", "1", "--queue-timeout-ms", "20"],
        ));
        let j2 = j.clone();
        let busy = tokio::spawn(async move { run(&j2).await });
        tokio::time::sleep(Duration::from_millis(50)).await;
        assert!(matches!(run(&j).await, Err(ApiError::Overloaded)));
        busy.abort();
    }

    #[tokio::test]
    async fn dropping_the_request_kills_the_worker() {
        let j = Arc::new(jobs("exec sleep 10", &[]));
        let j2 = j.clone();
        let request = tokio::spawn(async move { run(&j2).await });
        tokio::time::sleep(Duration::from_millis(50)).await;
        assert_eq!(j.active(), 1);
        request.abort();
        assert!(idle(&j).await, "the worker outlived its request");
    }

    #[tokio::test]
    async fn cpu_and_memory_limits_are_limit_errors() {
        let r = run(&jobs(
            "printf 'S\\001'; kill -XCPU $$",
            &["--worker-cpu-seconds", "3"],
        ))
        .await;
        assert!(
            matches!(&r, Err(ApiError::LimitExceeded(m))
                if m.starts_with("measuring the shape used more than the worker's 3 s of CPU")),
            "{r:?}"
        );
        let worker = "echo 'memory allocation of 64 bytes failed' >&2; kill -ABRT $$";
        let r = run(&jobs(worker, &["--worker-memory-mib", "100"])).await;
        assert!(
            matches!(&r, Err(ApiError::LimitExceeded(m))
                if m.starts_with("running the script needed more than the worker's 100 MiB")),
            "{r:?}"
        );
    }

    #[tokio::test]
    async fn crashes_and_garbage_are_internal_errors() {
        for worker in [
            "exit 3",
            "printf X",
            "printf 'S\\011'",
            &result_frame("not json", ""),
            "printf 'R\\377\\377\\377\\377'",
        ] {
            let r = run(&jobs(worker, &[])).await;
            assert!(matches!(r, Err(ApiError::Internal(_))), "{worker}: {r:?}");
        }
        let missing = Jobs {
            worker: Worker::at("/nonexistent/scratchcad"),
            ..jobs("", &[])
        };
        let r = run(&missing).await;
        assert!(
            matches!(&r, Err(ApiError::Internal(m)) if m.starts_with("starting")),
            "{r:?}"
        );
    }

    #[tokio::test]
    async fn crashes_are_reported_with_the_likely_cause() {
        let usr1 = format!("signal {}", Signal::USR1.as_raw());
        for (signal, name) in [("SEGV", "SIGSEGV"), ("USR1", usr1.as_str())] {
            let worker = format!("printf 'S\\002'; kill -{signal} $$");
            let r = run(&jobs(&worker, &["--worker-memory-mib", "300"])).await;
            let Err(ApiError::Crashed(m)) = r else {
                panic!("expected a crash, got {r:?}")
            };
            assert!(
                m.starts_with(&format!("the worker crashed ({name}) while meshing")),
                "{m}"
            );
            assert!(m.contains("each job may use 300 MiB"), "{m}");
        }
    }

    #[tokio::test]
    async fn replies_are_bounded() {
        // A 2 MiB body is over the limit: 1 MiB on top of a 1-byte export
        // and 1-pixel images
        let args = [
            "--max-export-bytes",
            "1",
            "--max-image-size-2d",
            "1",
            "--max-image-size-3d",
            "1",
        ];
        let worker = format!(
            "{}; head -c 2097152 /dev/zero",
            printf(&[RESULT], r#"{"Ok":null}"#, &2_097_152u64.to_le_bytes())
        );
        let r = run(&jobs(&worker, &args)).await;
        assert!(
            matches!(&r, Err(ApiError::Internal(m)) if m.contains("the limit is")),
            "{r:?}"
        );
    }

    #[tokio::test]
    async fn stderr_is_logged() {
        let worker = format!(
            "echo 'occt warning: w' >&2; echo 'occt fail: f' >&2; echo other >&2; \
             for i in $(seq 120); do echo $i >&2; done; {}",
            result_frame(r#"{"Ok":1}"#, "")
        );
        let (meta, _) = run(&jobs(&worker, &[])).await.unwrap();
        assert_eq!(meta, 1);
    }

    #[test]
    fn out_of_memory_messages() {
        assert!(is_out_of_memory("memory allocation of 8 bytes failed"));
        assert!(is_out_of_memory("meshing failed: Standard_OutOfMemory"));
        assert!(!is_out_of_memory(
            "meshing failed: Standard_ConstructionError"
        ));
    }
}
