//! Runtime configuration, sourced from CLI flags or `SCRATCHCAD_*` env vars.

use std::{net::SocketAddr, time::Duration};

use clap::Parser;

/// HTTP API for OpenCASCADE B-rep modelling: Rhai scripting, measuring, rendering and export
#[derive(Parser, Debug, Clone)]
#[command(version, about)]
pub struct Config {
    /// Address to listen on
    #[arg(long, env = "SCRATCHCAD_LISTEN", default_value = "0.0.0.0:8080")]
    pub listen: SocketAddr,

    /// Optional bearer token required on every `/v1` route
    #[arg(long, env = "SCRATCHCAD_API_TOKEN", hide_env_values = true)]
    pub api_token: Option<String>,

    /// Log output format
    #[arg(long, env = "SCRATCHCAD_LOG_FORMAT", value_enum, default_value_t = LogFormat::Text)]
    pub log_format: LogFormat,

    /// Maximum number of jobs executing at once; further requests queue
    #[arg(long, env = "SCRATCHCAD_MAX_CONCURRENT_JOBS", default_value_t = 4)]
    pub max_concurrent_jobs: usize,

    /// How long a request may wait for a job slot before getting a 503
    #[arg(long, env = "SCRATCHCAD_QUEUE_TIMEOUT_MS", default_value_t = 5_000)]
    pub queue_timeout_ms: u64,

    /// Wall-clock budget for a single job (script + measuring, rendering or
    /// export); its worker process is killed when it runs out
    #[arg(long, env = "SCRATCHCAD_JOB_TIMEOUT_MS", default_value_t = 60_000)]
    pub job_timeout_ms: u64,

    /// Heap memory (`RLIMIT_DATA`) each job's worker process may use, in MiB
    #[arg(long, env = "SCRATCHCAD_WORKER_MEMORY_MIB", default_value_t = 2048)]
    pub worker_memory_mib: u64,

    /// CPU time each job's worker process may use, in seconds
    #[arg(long, env = "SCRATCHCAD_WORKER_CPU_SECONDS", default_value_t = 120)]
    pub worker_cpu_seconds: u64,

    /// Maximum request body size in bytes
    #[arg(long, env = "SCRATCHCAD_MAX_BODY_BYTES", default_value_t = 4 * 1024 * 1024)]
    pub max_body_bytes: usize,

    /// Maximum Rhai script size in bytes
    #[arg(long, env = "SCRATCHCAD_MAX_SCRIPT_BYTES", default_value_t = 64 * 1024)]
    pub max_script_bytes: usize,

    /// Maximum number of Rhai operations a script may execute
    #[arg(
        long,
        env = "SCRATCHCAD_MAX_SCRIPT_OPERATIONS",
        default_value_t = 1_000_000
    )]
    pub max_script_operations: u64,

    /// Maximum width / height of a 2D raster image
    #[arg(long, env = "SCRATCHCAD_MAX_IMAGE_SIZE_2D", default_value_t = 4096)]
    pub max_image_size_2d: u32,

    /// Maximum width / height of a 3D raster image
    #[arg(long, env = "SCRATCHCAD_MAX_IMAGE_SIZE_3D", default_value_t = 2048)]
    pub max_image_size_3d: u32,

    /// Maximum number of triangles in a mesh, for an export or a render
    #[arg(
        long,
        env = "SCRATCHCAD_MAX_MESH_TRIANGLES",
        default_value_t = 4_000_000
    )]
    pub max_mesh_triangles: usize,

    /// Maximum number of faces in a shape; larger shapes are rejected before
    /// they are measured, meshed or exported
    #[arg(long, env = "SCRATCHCAD_MAX_FACES", default_value_t = 100_000)]
    pub max_faces: usize,

    /// Maximum size of an exported file in bytes
    #[arg(
        long,
        env = "SCRATCHCAD_MAX_EXPORT_BYTES",
        default_value_t = 128 * 1024 * 1024
    )]
    pub max_export_bytes: usize,
}

#[derive(clap::ValueEnum, Debug, Clone, Copy, PartialEq, Eq)]
pub enum LogFormat {
    Text,
    Json,
}

impl Config {
    pub fn queue_timeout(&self) -> Duration {
        Duration::from_millis(self.queue_timeout_ms)
    }

    pub fn job_timeout(&self) -> Duration {
        Duration::from_millis(self.job_timeout_ms)
    }

    /// Upper bound on total request latency, used by the outer timeout layer
    /// as a backstop in case a handler misbehaves.
    pub fn request_timeout(&self) -> Duration {
        self.queue_timeout() + self.job_timeout() + Duration::from_secs(5)
    }

    /// Checks invariants that clap cannot express
    pub fn validate(&self) -> Result<(), String> {
        let nonzero = [
            ("max_concurrent_jobs", self.max_concurrent_jobs as u64),
            ("job_timeout_ms", self.job_timeout_ms),
            ("max_body_bytes", self.max_body_bytes as u64),
            ("max_script_bytes", self.max_script_bytes as u64),
            // Rhai treats 0 as "unlimited"
            ("max_script_operations", self.max_script_operations),
            ("max_image_size_2d", self.max_image_size_2d.into()),
            ("max_image_size_3d", self.max_image_size_3d.into()),
            ("max_mesh_triangles", self.max_mesh_triangles as u64),
            ("max_faces", self.max_faces as u64),
            ("max_export_bytes", self.max_export_bytes as u64),
            ("worker_memory_mib", self.worker_memory_mib),
            ("worker_cpu_seconds", self.worker_cpu_seconds),
        ];
        if let Some((name, _)) = nonzero.iter().find(|(_, v)| *v == 0) {
            return Err(format!("{name} must be at least 1"));
        }
        if self.max_script_bytes > self.max_body_bytes {
            return Err("max_script_bytes must not exceed max_body_bytes".into());
        }
        if matches!(&self.api_token, Some(t) if t.len() < 16) {
            return Err("api_token must be at least 16 characters".into());
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn validation() {
        let parse = |args: &[&str]| {
            Config::parse_from(std::iter::once("scratchcad").chain(args.iter().copied()))
        };
        assert!(parse(&[]).validate().is_ok());
        assert!(parse(&["--max-mesh-triangles", "0"]).validate().is_err());
        assert!(parse(&["--max-script-operations", "0"]).validate().is_err());
        assert!(parse(&["--max-faces", "0"]).validate().is_err());
        assert!(parse(&["--worker-memory-mib", "0"]).validate().is_err());
        assert!(parse(&["--api-token", "short"]).validate().is_err());
        assert!(
            parse(&["--max-body-bytes", "10", "--max-script-bytes", "20"])
                .validate()
                .is_err()
        );
    }
}
