use std::time::Duration;

use clap::Parser;
use scratchcad::{
    AppState,
    config::{Config, LogFormat},
};
use tracing_subscriber::EnvFilter;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let config = Config::parse();
    config.validate()?;
    init_tracing(config.log_format);
    // OpenCASCADE reports on its own progress (STEP transfer statistics, for
    // example) on stdout, which carries our logs; keep it to failures.
    scratchcad_occt_rhai::set_occt_messages(false);

    let rt = tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .build()?;
    let result = rt.block_on(serve(config));
    // Abandoned blocking jobs have been cancelled and normally stop quickly;
    // never let a stuck one hold the process open indefinitely.
    rt.shutdown_timeout(Duration::from_secs(5));
    tracing::info!("shutdown complete");
    result
}

async fn serve(config: Config) -> Result<(), Box<dyn std::error::Error>> {
    let listener = tokio::net::TcpListener::bind(config.listen).await?;
    tracing::info!(
        addr = %listener.local_addr()?,
        max_concurrent_jobs = config.max_concurrent_jobs,
        auth = config.api_token.is_some(),
        "listening"
    );
    if config.api_token.is_none() {
        tracing::warn!("SCRATCHCAD_API_TOKEN is not set; the API is unauthenticated");
    }

    let state = AppState::new(config);
    let app = scratchcad::router(state.clone());

    let drain = state.clone();
    axum::serve(listener, app)
        .with_graceful_shutdown(async move {
            shutdown_signal().await;
            tracing::info!("shutdown signal received; draining");
            drain.start_draining();
        })
        .await?;
    Ok(())
}

async fn shutdown_signal() {
    let ctrl_c = async {
        let _ = tokio::signal::ctrl_c().await;
    };
    #[cfg(unix)]
    let terminate = async {
        match tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate()) {
            Ok(mut s) => {
                s.recv().await;
            }
            Err(e) => {
                tracing::error!("failed to install SIGTERM handler: {e}");
                std::future::pending::<()>().await
            }
        }
    };
    #[cfg(not(unix))]
    let terminate = std::future::pending::<()>();
    tokio::select! {
        () = ctrl_c => {},
        () = terminate => {},
    }
}

fn init_tracing(format: LogFormat) {
    let filter = EnvFilter::try_from_default_env()
        .unwrap_or_else(|_| EnvFilter::new("info,tower_http=info"));
    // Colour only on a terminal, so log collectors don't get escape codes.
    let ansi = std::io::IsTerminal::is_terminal(&std::io::stdout());
    let builder = tracing_subscriber::fmt()
        .with_env_filter(filter)
        .with_ansi(ansi);
    match format {
        LogFormat::Json => builder.json().init(),
        LogFormat::Text => builder.init(),
    }
}
