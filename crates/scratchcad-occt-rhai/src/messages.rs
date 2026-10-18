//! Where OpenCASCADE's own diagnostic messages go.
//!
//! By default OpenCASCADE prints them (STEP and IGES transfer statistics, warnings, failures) to
//! stdout. A program whose stdout carries something else (a protocol, structured logs) should
//! call [`set_message_handler`] to receive them itself, or [`set_occt_messages`] to send them to
//! stderr. These settings are process-wide.
//!
//! The first call replaces OpenCASCADE's printer with one that hands every message to this
//! module; later calls only change where this module sends them, so they are safe at any time.
//! Make the first call early (before other threads start using OpenCASCADE) to be sure no
//! message is being printed while the printer is swapped. OpenCASCADE writes a few messages
//! straight to `std::cout` without going through its printers; those cannot be redirected.

use scratchcad_occt_sys::message::{self as ffi, Message_Gravity};
use std::sync::{Arc, Once, RwLock};

/// The severity of an OpenCASCADE message, from least to most severe.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum MessageLevel {
    Trace,
    Info,
    Warning,
    Alarm,
    Fail,
}

impl MessageLevel {
    fn from_ffi(gravity: Message_Gravity) -> Self {
        match gravity {
            Message_Gravity::Message_Trace => MessageLevel::Trace,
            Message_Gravity::Message_Info => MessageLevel::Info,
            Message_Gravity::Message_Warning => MessageLevel::Warning,
            Message_Gravity::Message_Alarm => MessageLevel::Alarm,
            _ => MessageLevel::Fail,
        }
    }
}

type Handler = dyn Fn(MessageLevel, &str) + Send + Sync;

enum Sink {
    Stdout,
    Stderr,
    Handler(Arc<Handler>),
}

/// Messages below the level are dropped; the rest go to the sink.
static ROUTE: RwLock<(MessageLevel, Sink)> = RwLock::new((MessageLevel::Info, Sink::Stdout));

fn route(level: MessageLevel, sink: Sink) {
    static INSTALL: Once = Once::new();
    *ROUTE.write().unwrap_or_else(|poisoned| poisoned.into_inner()) = (level, sink);
    INSTALL.call_once(|| {
        ffi::set_message_handler(Some(Arc::new(|gravity: Message_Gravity, text: &str| {
            deliver(MessageLevel::from_ffi(gravity), text)
        })));
        // STEP and IGES translation produce most messages; keep them out while the printer is
        // swapped.
        crate::io::translator(|| {
            ffi::Message_use_rust_printer(Message_Gravity::Message_Trace);
            Ok(())
        })
        .expect("installing the printer cannot fail");
    });
}

fn deliver(level: MessageLevel, text: &str) {
    let handler = {
        let route = ROUTE.read().unwrap_or_else(|poisoned| poisoned.into_inner());
        if level < route.0 {
            return;
        }
        match &route.1 {
            Sink::Stdout => return println!("{text}"),
            Sink::Stderr => return eprintln!("{text}"),
            Sink::Handler(handler) => handler.clone(),
        }
    };
    // Called without holding the lock, so the handler may reconfigure messages.
    handler(level, text);
}

/// Sends every OpenCASCADE message at or above `level` to `handler` instead of stdout.
///
/// The handler may be called from any thread, including OpenCASCADE's worker threads; a
/// handler that panics loses that message.
pub fn set_message_handler(
    level: MessageLevel,
    handler: impl Fn(MessageLevel, &str) + Send + Sync + 'static,
) {
    route(level, Sink::Handler(Arc::new(handler)));
}

/// Shows OpenCASCADE's messages (from [`MessageLevel::Info`] up) on stdout, as it does by
/// default, or, when `enabled` is false, only its failures, on stderr.
pub fn set_occt_messages(enabled: bool) {
    if enabled {
        route(MessageLevel::Info, Sink::Stdout);
    } else {
        route(MessageLevel::Fail, Sink::Stderr);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn levels_convert_and_are_ordered() {
        let cases = [
            (Message_Gravity::Message_Trace, MessageLevel::Trace),
            (Message_Gravity::Message_Info, MessageLevel::Info),
            (Message_Gravity::Message_Warning, MessageLevel::Warning),
            (Message_Gravity::Message_Alarm, MessageLevel::Alarm),
            (Message_Gravity::Message_Fail, MessageLevel::Fail),
        ];
        for (gravity, level) in cases {
            assert_eq!(MessageLevel::from_ffi(gravity), level);
        }
        assert!(cases.windows(2).all(|pair| pair[0].1 < pair[1].1));
    }
}
