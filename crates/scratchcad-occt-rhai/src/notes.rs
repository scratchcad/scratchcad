//! Warnings about operations that succeeded but whose results are suspect, such as a boolean that
//! returned an invalid shape. Operations record them as they run, and the host takes them after a
//! script with [`take_notes`] to show them: a script's final shape can look fine after a later
//! operation silently dropped the damaged part.
//!
//! Notes are kept per thread, as shapes never leave theirs.

use std::cell::RefCell;

/// The most notes kept; later ones are dropped.
const MAX_NOTES: usize = 20;

struct Note {
    message: String,
    /// Where in the script the operation was called, such as "line 3, position 9".
    position: Option<String>,
}

thread_local! {
    static NOTES: RefCell<Vec<Note>> = const { RefCell::new(Vec::new()) };
}

pub(crate) fn note(message: String) {
    NOTES.with_borrow_mut(|notes| {
        if notes.len() < MAX_NOTES {
            notes.push(Note { message, position: None });
        }
    });
}

/// How many notes there are, to tell which ones a call adds.
pub(crate) fn count() -> usize {
    NOTES.with_borrow(Vec::len)
}

/// Places the notes recorded since there were `start` of them at `position` in the script,
/// unless an operation nested deeper already placed them.
pub(crate) fn locate(start: usize, position: &str) {
    NOTES.with_borrow_mut(|notes| {
        for note in notes.iter_mut().skip(start).filter(|n| n.position.is_none()) {
            note.position = Some(position.to_string());
        }
    });
}

/// Takes the notes recorded on this thread, oldest first, each prefixed with where in the script
/// its operation was called when that is known.
pub fn take_notes() -> Vec<String> {
    NOTES
        .with_borrow_mut(std::mem::take)
        .into_iter()
        .map(|n| match n.position {
            Some(position) => format!("{position}: {}", n.message),
            None => n.message,
        })
        .collect()
}
