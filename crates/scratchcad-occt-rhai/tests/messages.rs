//! Redirecting OpenCASCADE's console output. The settings are process-wide, so everything is
//! checked in one test.

use scratchcad_occt_rhai::{set_message_handler, set_occt_messages, MessageLevel, Shape};
use std::sync::{Arc, Mutex};

#[test]
fn messages_go_where_they_are_sent() {
    let seen = Arc::new(Mutex::new(Vec::new()));
    let sink = seen.clone();
    set_message_handler(MessageLevel::Info, move |level, text| {
        sink.lock().unwrap().push((level, text.to_owned()));
    });
    // Writing STEP reports transfer statistics.
    Shape::cube(1.0).unwrap().to_step().unwrap();
    {
        let seen = seen.lock().unwrap();
        assert!(!seen.is_empty());
        assert!(seen.iter().all(|(level, _)| *level >= MessageLevel::Info));
    }

    // Only failures pass a `Fail` handler.
    seen.lock().unwrap().clear();
    let sink = seen.clone();
    set_message_handler(MessageLevel::Fail, move |level, text| {
        sink.lock().unwrap().push((level, text.to_owned()));
    });
    Shape::cube(1.0).unwrap().to_step().unwrap();
    assert!(seen.lock().unwrap().is_empty());

    // A handler may reconfigure messages; this one sends the rest to stderr.
    let calls = Arc::new(Mutex::new(0));
    let counter = calls.clone();
    set_message_handler(MessageLevel::Trace, move |_, _| {
        *counter.lock().unwrap() += 1;
        set_occt_messages(false);
    });
    Shape::cube(1.0).unwrap().to_step().unwrap();
    assert_eq!(*calls.lock().unwrap(), 1);

    // Back to printing: the handler no longer hears anything.
    set_occt_messages(false);
    Shape::cube(1.0).unwrap().to_step().unwrap();
    set_occt_messages(true);
    assert!(seen.lock().unwrap().is_empty());
    set_occt_messages(false);
}
