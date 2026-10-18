// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

use std::{
    panic::{catch_unwind, AssertUnwindSafe},
    sync::{
        atomic::{AtomicBool, Ordering},
        Arc, RwLock,
    },
};

// cxx generates the wrapper of `Message_CancellableProgress_new` without the `# Safety`
// section its declaration documents.
#[allow(clippy::missing_safety_doc)]
#[cxx::bridge]
mod inner {
    /// Severity of OpenCASCADE's diagnostic messages.
    #[derive(Debug)]
    #[repr(u32)]
    pub enum Message_Gravity {
        Message_Trace,
        Message_Info,
        Message_Warning,
        Message_Alarm,
        Message_Fail,
    }

    extern "Rust" {
        type CancelFlag;
        fn cancel_requested(flag: &CancelFlag) -> bool;
        fn deliver_message(gravity: Message_Gravity, text: &[u8]);
    }

    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/message.hxx");

        type Message_Gravity;

        type Message_ProgressRange;

        /// A range without a progress indicator: the algorithm it is passed to cannot be
        /// interrupted.
        #[cxx_name = "construct_unique"]
        pub fn Message_ProgressRange_new() -> UniquePtr<Message_ProgressRange>;

        /// A progress indicator that asks `flag` whether to stop, with the root range it hands
        /// out. OpenCASCADE algorithms given that range poll the flag and abort once it is set.
        type Message_CancellableProgress;

        /// # Safety
        ///
        /// `flag` must outlive the returned progress: the indicator keeps a reference to it.
        pub unsafe fn Message_CancellableProgress_new(
            flag: &CancelFlag,
        ) -> UniquePtr<Message_CancellableProgress>;

        /// The range to pass to an algorithm. A range can only be used for one algorithm.
        pub fn Message_CancellableProgress_range(
            progress: &Message_CancellableProgress,
        ) -> &Message_ProgressRange;

        /// Only messages at least as severe as `level` are printed by the default messenger
        /// (which, among others, prints STEP/IGES transfer statistics to stdout).
        pub fn Message_set_default_trace_level(level: Message_Gravity);

        /// The number of printers attached to the default messenger.
        pub fn Message_default_printer_count() -> i32;

        /// Replaces the default messenger's printers with one that passes every message at or
        /// above `level` to the handler set with [`set_message_handler`](super::set_message_handler).
        ///
        /// OpenCASCADE does not synchronize its printer list: do not call this while another
        /// thread may be sending a message (call it once, at startup, and change the handler
        /// instead).
        pub fn Message_use_rust_printer(level: Message_Gravity);

        /// Replaces the default messenger's printers with one that writes messages at or above
        /// `level` to stdout, or to stderr when `to_stderr` is set. The same caveat as for
        /// [`Message_use_rust_printer`] applies.
        pub fn Message_use_stream_printer(to_stderr: bool, level: Message_Gravity);
    }
}

/// A flag that OpenCASCADE algorithms poll (through [`Message_CancellableProgress`]) to find out
/// whether they should stop.
#[derive(Debug, Default)]
pub struct CancelFlag(AtomicBool);

impl CancelFlag {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn cancel(&self) {
        self.0.store(true, Ordering::Relaxed);
    }

    pub fn is_cancelled(&self) -> bool {
        self.0.load(Ordering::Relaxed)
    }
}

fn cancel_requested(flag: &CancelFlag) -> bool {
    flag.is_cancelled()
}

/// Receives OpenCASCADE's messages once [`Message_use_rust_printer`] is installed.
pub type MessageHandler = dyn Fn(Message_Gravity, &str) + Send + Sync;

static MESSAGE_HANDLER: RwLock<Option<Arc<MessageHandler>>> = RwLock::new(None);

/// Sets (or, with `None`, removes) the function that receives OpenCASCADE's messages once
/// [`Message_use_rust_printer`] is installed. Messages arriving without a handler are dropped.
pub fn set_message_handler(handler: Option<Arc<MessageHandler>>) {
    *MESSAGE_HANDLER.write().unwrap_or_else(|poisoned| poisoned.into_inner()) = handler;
}

fn deliver_message(gravity: Message_Gravity, text: &[u8]) {
    let handler = MESSAGE_HANDLER.read().unwrap_or_else(|poisoned| poisoned.into_inner()).clone();
    if let Some(handler) = handler {
        // A panic must not unwind into C++; a handler that panics loses that message.
        let _ = catch_unwind(AssertUnwindSafe(|| handler(gravity, &String::from_utf8_lossy(text))));
    }
}
