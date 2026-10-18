//! Cancelling long-running OpenCASCADE algorithms.
//!
//! Booleans, shells, meshing and STEP/IGES/BREP conversion can take a long time on complex
//! shapes. Run them inside [`with_cancel`] and they poll the [`CancelToken`] while they work:
//! once it is cancelled (from any thread) the running algorithm stops and the operation fails
//! with [`Error::Cancelled`]. Meshing stops between faces, so a single huge face still finishes.
//!
//! OpenCASCADE 7.8 ignores the progress range of fillets, chamfers and lofts, and sweeps and
//! `clean` take none, so once started those run to completion; under a cancelled token they fail
//! with [`Error::Cancelled`] without starting.
//!
//! ```no_run
//! use scratchcad_occt_rhai::{with_cancel, CancelToken, Error, Shape};
//!
//! let token = CancelToken::new();
//! let watchdog = token.clone();
//! std::thread::spawn(move || {
//!     std::thread::sleep(std::time::Duration::from_secs(5));
//!     watchdog.cancel();
//! });
//! let result = with_cancel(&token, || Shape::cube(10.0)?.fillet_all(1.0));
//! assert!(matches!(result, Ok(_) | Err(Error::Cancelled)));
//! ```
//!
//! Scripts are covered too: evaluate them inside [`with_cancel`]. To also stop the Rhai side of a
//! script (loops between OpenCASCADE calls), check the token in the engine's `on_progress`
//! callback.

use crate::error::Error;
use scratchcad_occt_sys as ffi;
use std::{cell::RefCell, ops::Deref, sync::Arc};

/// A shared flag that asks the OpenCASCADE algorithms run under [`with_cancel`] to stop.
///
/// Cloning is cheap and every clone controls the same flag. Once cancelled, a token stays
/// cancelled.
#[derive(Debug, Clone, Default)]
pub struct CancelToken(Arc<ffi::message::CancelFlag>);

impl CancelToken {
    pub fn new() -> Self {
        Self::default()
    }

    /// Asks running and future operations under this token to stop.
    pub fn cancel(&self) {
        self.0.cancel();
    }

    pub fn is_cancelled(&self) -> bool {
        self.0.is_cancelled()
    }
}

thread_local! {
    static CURRENT: RefCell<Option<CancelToken>> = const { RefCell::new(None) };
}

/// Restores the previous token when the scope ends, even if `f` panics.
struct Scope(Option<CancelToken>);

impl Drop for Scope {
    fn drop(&mut self) {
        CURRENT.with(|current| *current.borrow_mut() = self.0.take());
    }
}

/// Runs `f` with every OpenCASCADE algorithm it starts on this thread watching `token`.
///
/// Scopes nest: the innermost token applies, and the previous one is restored afterwards.
pub fn with_cancel<T>(token: &CancelToken, f: impl FnOnce() -> T) -> T {
    let previous = CURRENT.with(|current| current.borrow_mut().replace(token.clone()));
    let _scope = Scope(previous);
    f()
}

/// The token of the innermost [`with_cancel`] scope on this thread, if any.
pub fn current_token() -> Option<CancelToken> {
    CURRENT.with(|current| current.borrow().clone())
}

/// Whether this thread runs under a token that has been cancelled.
pub(crate) fn is_cancelled() -> bool {
    CURRENT.with(|current| current.borrow().as_ref().is_some_and(CancelToken::is_cancelled))
}

/// The error for an algorithm that finished without a result: [`Error::Cancelled`] when it was
/// asked to stop, otherwise [`Error::OperationFailed`].
pub(crate) fn failed(operation: &'static str) -> Error {
    if is_cancelled() {
        Error::Cancelled
    } else {
        Error::OperationFailed(operation)
    }
}

/// Fails with [`Error::Cancelled`] if the current token has been cancelled, so that an
/// operation does not start work it would be asked to abandon.
pub(crate) fn check() -> Result<(), Error> {
    if is_cancelled() {
        Err(Error::Cancelled)
    } else {
        Ok(())
    }
}

/// A progress range for one OpenCASCADE algorithm. Under [`with_cancel`] the algorithm polls the
/// scope's token through it; otherwise it cannot be interrupted.
pub(crate) struct Progress {
    // Declared before `_token`, so it is dropped first: the C++ indicator refers to the flag.
    inner: ProgressInner,
    _token: Option<CancelToken>,
}

enum ProgressInner {
    Plain(cxx::UniquePtr<ffi::message::Message_ProgressRange>),
    Cancellable(cxx::UniquePtr<ffi::message::Message_CancellableProgress>),
}

/// A fresh progress range for the next algorithm. Each range must be used for one algorithm.
pub(crate) fn progress() -> Progress {
    match current_token() {
        Some(token) => {
            // SAFETY: `Progress` keeps `token` (and so the flag it points to) alive for at least
            // as long as the C++ object, which is dropped first.
            let inner = unsafe { ffi::message::Message_CancellableProgress_new(&token.0) };
            Progress { inner: ProgressInner::Cancellable(inner), _token: Some(token) }
        },
        None => Progress {
            inner: ProgressInner::Plain(ffi::message::Message_ProgressRange_new()),
            _token: None,
        },
    }
}

impl Deref for Progress {
    type Target = ffi::message::Message_ProgressRange;

    fn deref(&self) -> &Self::Target {
        match &self.inner {
            ProgressInner::Plain(range) => range,
            ProgressInner::Cancellable(progress) => {
                ffi::message::Message_CancellableProgress_range(progress)
            },
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn scopes_nest_and_restore() {
        assert!(current_token().is_none());
        let outer = CancelToken::new();
        let inner = CancelToken::new();
        inner.cancel();
        with_cancel(&outer, || {
            assert!(!is_cancelled());
            with_cancel(&inner, || {
                assert!(is_cancelled());
                assert!(matches!(failed("x"), Error::Cancelled));
                assert!(check().is_err());
            });
            assert!(!is_cancelled());
            assert!(matches!(failed("x"), Error::OperationFailed("x")));
            assert!(check().is_ok());
        });
        assert!(current_token().is_none());
    }

    #[test]
    fn scope_is_restored_after_a_panic() {
        let token = CancelToken::new();
        let result = std::panic::catch_unwind(|| with_cancel(&token, || panic!("boom")));
        assert!(result.is_err());
        assert!(current_token().is_none());
    }

    #[test]
    fn clones_share_the_flag() {
        let token = CancelToken::new();
        let clone = token.clone();
        assert!(!clone.is_cancelled());
        token.cancel();
        assert!(clone.is_cancelled());
    }

    #[test]
    fn progress_ranges_exist_with_and_without_a_token() {
        let _plain: &ffi::message::Message_ProgressRange = &progress();
        let token = CancelToken::new();
        with_cancel(&token, || {
            let _cancellable: &ffi::message::Message_ProgressRange = &progress();
        });
    }
}
