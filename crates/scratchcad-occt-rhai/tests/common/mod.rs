//! Helpers shared by the integration tests. All tests run against the real OpenCASCADE build.
#![allow(dead_code)]

use scratchcad_occt_rhai::{DVec3, Error, Shape};

#[track_caller]
pub fn assert_close(actual: f64, expected: f64, tolerance: f64) {
    assert!(
        (actual - expected).abs() <= tolerance,
        "expected {expected} ± {tolerance}, got {actual}"
    );
}

#[track_caller]
pub fn assert_vec_close(actual: DVec3, expected: DVec3, tolerance: f64) {
    assert!(
        actual.abs_diff_eq(expected, tolerance),
        "expected {expected} ± {tolerance}, got {actual}"
    );
}

/// The error message of a failed result, panicking if it succeeded.
#[track_caller]
pub fn err<T>(result: Result<T, Error>) -> Error {
    match result {
        Ok(_) => panic!("expected an error"),
        Err(e) => e,
    }
}

#[track_caller]
pub fn err_contains<T>(result: Result<T, Error>, needle: &str) {
    let message = err(result).to_string();
    assert!(message.contains(needle), "{message:?} does not contain {needle:?}");
}

pub fn v(x: f64, y: f64, z: f64) -> DVec3 {
    DVec3::new(x, y, z)
}

pub fn cube10() -> Shape {
    Shape::cube(10.0).unwrap()
}

pub fn temp_dir() -> tempfile::TempDir {
    tempfile::tempdir().unwrap()
}
