use rhai::{Dynamic, EvalAltResult, Position, INT};

/// Everything that can go wrong while building or querying geometry.
///
/// Every fallible operation in this crate returns [`Result`]. When called from a Rhai script the
/// error is turned into a runtime error carrying [`Error`]'s `Display` text, tagged with its
/// [`ErrorKind`] (see [`error_kind`]); scripts can intercept it with
/// `try { ... } catch (err) { ... }` and read the kind as `err.tag`.
#[derive(Debug, Clone, PartialEq, thiserror::Error)]
pub enum Error {
    /// OpenCASCADE threw an exception (`<exception type>: <message>`).
    #[error("OpenCASCADE error: {0}")]
    Occt(String),
    /// An OpenCASCADE algorithm finished without producing a result.
    #[error("{0} failed")]
    OperationFailed(&'static str),
    /// A shape of the wrong topological type was passed to an operation.
    #[error("expected {expected}, got {actual}")]
    WrongShapeType { expected: &'static str, actual: &'static str },
    /// An argument was out of range or otherwise unusable.
    #[error("invalid argument: {0}")]
    InvalidArgument(String),
    /// A selection was empty where at least one shape was required.
    #[error("selection is empty: {0}")]
    EmptySelection(String),
    /// An index was out of range.
    #[error("index {index} out of range for selection of {len} shapes")]
    IndexOutOfRange { index: i64, len: usize },
    /// A selector string could not be parsed.
    #[error("invalid selector {selector:?}: {message}")]
    Selector { selector: String, message: String },
    /// Reading or writing a file (or converting a shape to or from a file format) failed.
    #[error("{0}")]
    Io(String),
    /// The operation was stopped through its [`CancelToken`](crate::CancelToken).
    #[error("the operation was cancelled")]
    Cancelled,
}

/// The kind of an [`Error`], without its details.
///
/// In scripts, errors raised by this crate carry their kind's [`tag`](ErrorKind::tag) (readable
/// as `err.tag` in a `catch` block); hosts recover the kind with [`error_kind`].
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum ErrorKind {
    Occt,
    OperationFailed,
    WrongShapeType,
    InvalidArgument,
    EmptySelection,
    IndexOutOfRange,
    Selector,
    Io,
    Cancelled,
}

impl ErrorKind {
    pub const ALL: [ErrorKind; 9] = [
        ErrorKind::Occt,
        ErrorKind::OperationFailed,
        ErrorKind::WrongShapeType,
        ErrorKind::InvalidArgument,
        ErrorKind::EmptySelection,
        ErrorKind::IndexOutOfRange,
        ErrorKind::Selector,
        ErrorKind::Io,
        ErrorKind::Cancelled,
    ];

    /// The tag attached to script errors of this kind. Tags start at 1: plain values (and errors
    /// a script throws itself) have tag 0.
    pub fn tag(self) -> INT {
        match self {
            ErrorKind::Occt => 1,
            ErrorKind::OperationFailed => 2,
            ErrorKind::WrongShapeType => 3,
            ErrorKind::InvalidArgument => 4,
            ErrorKind::EmptySelection => 5,
            ErrorKind::IndexOutOfRange => 6,
            ErrorKind::Selector => 7,
            ErrorKind::Io => 8,
            ErrorKind::Cancelled => 9,
        }
    }

    /// The kind whose [`tag`](ErrorKind::tag) is `tag`.
    pub fn from_tag(tag: INT) -> Option<Self> {
        Self::ALL.into_iter().find(|kind| kind.tag() == tag)
    }
}

impl Error {
    pub fn kind(&self) -> ErrorKind {
        match self {
            Error::Occt(_) => ErrorKind::Occt,
            Error::OperationFailed(_) => ErrorKind::OperationFailed,
            Error::WrongShapeType { .. } => ErrorKind::WrongShapeType,
            Error::InvalidArgument(_) => ErrorKind::InvalidArgument,
            Error::EmptySelection(_) => ErrorKind::EmptySelection,
            Error::IndexOutOfRange { .. } => ErrorKind::IndexOutOfRange,
            Error::Selector { .. } => ErrorKind::Selector,
            Error::Io(_) => ErrorKind::Io,
            Error::Cancelled => ErrorKind::Cancelled,
        }
    }
}

/// The [`ErrorKind`] of an error raised by this crate inside a script, looking through the
/// function calls it passed through. `None` for Rhai's own errors and for values the script
/// threw itself (unless it re-threw a caught error). Scripts on an engine set up by
/// [`register`](crate::register) can read tags but not set them, so the kind always comes from an
/// error this crate raised.
pub fn error_kind(error: &EvalAltResult) -> Option<ErrorKind> {
    match error.unwrap_inner() {
        EvalAltResult::ErrorRuntime(value, _) => ErrorKind::from_tag(value.tag().into()),
        _ => None,
    }
}

pub type Result<T, E = Error> = std::result::Result<T, E>;

impl From<cxx::Exception> for Error {
    fn from(exception: cxx::Exception) -> Self {
        // Some algorithms throw when they notice they were asked to stop.
        if crate::cancel::is_cancelled() {
            return Error::Cancelled;
        }
        Error::Occt(exception.what().to_owned())
    }
}

impl From<Error> for Box<EvalAltResult> {
    fn from(error: Error) -> Self {
        let mut value = Dynamic::from(error.to_string());
        // Tags are at most 9, so they fit the tag type of every pointer width.
        value.set_tag(error.kind().tag() as _);
        EvalAltResult::ErrorRuntime(value, Position::NONE).into()
    }
}

pub(crate) fn invalid(message: impl Into<String>) -> Error {
    Error::InvalidArgument(message.into())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn kinds_round_trip_through_tags() {
        let mut tags: Vec<INT> = ErrorKind::ALL.iter().map(|kind| kind.tag()).collect();
        tags.sort_unstable();
        tags.dedup();
        assert_eq!(tags.len(), ErrorKind::ALL.len());
        for kind in ErrorKind::ALL {
            assert_eq!(ErrorKind::from_tag(kind.tag()), Some(kind));
        }
        assert_eq!(ErrorKind::from_tag(0), None);
    }

    #[test]
    fn every_error_has_its_kind() {
        let cases = [
            (Error::Occt("x".into()), ErrorKind::Occt),
            (Error::OperationFailed("x"), ErrorKind::OperationFailed),
            (Error::WrongShapeType { expected: "a", actual: "b" }, ErrorKind::WrongShapeType),
            (Error::InvalidArgument("x".into()), ErrorKind::InvalidArgument),
            (Error::EmptySelection("x".into()), ErrorKind::EmptySelection),
            (Error::IndexOutOfRange { index: 1, len: 0 }, ErrorKind::IndexOutOfRange),
            (Error::Selector { selector: "s".into(), message: "m".into() }, ErrorKind::Selector),
            (Error::Io("x".into()), ErrorKind::Io),
            (Error::Cancelled, ErrorKind::Cancelled),
        ];
        for (error, kind) in cases {
            assert_eq!(error.kind(), kind);
            let script_error: Box<EvalAltResult> = error.clone().into();
            assert_eq!(error_kind(&script_error), Some(kind));
            assert!(script_error.to_string().contains(&error.to_string()));
        }
    }

    #[test]
    fn errors_without_a_kind() {
        let thrown: Box<EvalAltResult> =
            EvalAltResult::ErrorRuntime("mine".into(), Position::NONE).into();
        assert_eq!(error_kind(&thrown), None);
        let other: Box<EvalAltResult> =
            EvalAltResult::ErrorVariableNotFound("x".into(), Position::NONE).into();
        assert_eq!(error_kind(&other), None);
    }
}
