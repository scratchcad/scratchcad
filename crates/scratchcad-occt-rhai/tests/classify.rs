//! Whether points lie inside solids.

mod common;

use common::{cube10, err_contains, v};
use scratchcad_occt_rhai::{PointLocation, Shape, CLASSIFY_TOLERANCE};

#[test]
fn points_inside_outside_and_on_a_solid() {
    let cube = cube10();
    assert_eq!(cube.classify(v(5.0, 5.0, 5.0)).unwrap(), PointLocation::Inside);
    assert_eq!(cube.classify(v(15.0, 5.0, 5.0)).unwrap(), PointLocation::Outside);
    assert_eq!(cube.classify(v(10.0, 5.0, 5.0)).unwrap(), PointLocation::OnBoundary);
    assert_eq!(
        cube.classify(v(10.0 + CLASSIFY_TOLERANCE / 2.0, 5.0, 5.0)).unwrap(),
        PointLocation::OnBoundary
    );
    assert!(cube.contains(v(5.0, 5.0, 5.0)).unwrap());
    assert!(cube.contains(v(0.0, 0.0, 0.0)).unwrap());
    assert!(!cube.contains(v(-1.0, 5.0, 5.0)).unwrap());

    // A hole is outside.
    let pipe = cube
        .cut(&Shape::cylinder_at(v(5.0, 5.0, 0.0), v(0.0, 0.0, 1.0), 2.0, 10.0).unwrap())
        .unwrap();
    assert_eq!(pipe.classify(v(5.0, 5.0, 5.0)).unwrap(), PointLocation::Outside);
    assert_eq!(pipe.classify(v(1.0, 1.0, 5.0)).unwrap(), PointLocation::Inside);
}

#[test]
fn compounds_classify_against_every_solid() {
    let pair = Shape::compound(&[
        Shape::cube(1.0).unwrap(),
        Shape::cube(1.0).unwrap().translate(v(5.0, 0.0, 0.0)).unwrap(),
    ])
    .unwrap();
    assert_eq!(pair.classify(v(5.5, 0.5, 0.5)).unwrap(), PointLocation::Inside);
    assert_eq!(pair.classify(v(0.5, 0.5, 0.5)).unwrap(), PointLocation::Inside);
    assert_eq!(pair.classify(v(3.0, 0.5, 0.5)).unwrap(), PointLocation::Outside);
    assert_eq!(pair.classify(v(6.0, 0.5, 0.5)).unwrap(), PointLocation::OnBoundary);
}

#[test]
fn classification_needs_a_solid_and_a_finite_point() {
    let face =
        Shape::face_from(&Shape::circle(v(0.0, 0.0, 0.0), v(0.0, 0.0, 1.0), 1.0).unwrap()).unwrap();
    err_contains(face.classify(v(0.0, 0.0, 0.0)), "expected solid");
    err_contains(cube10().classify(v(f64::NAN, 0.0, 0.0)), "must be finite");
    assert_eq!(PointLocation::Inside.to_string(), "inside");
    assert_eq!(PointLocation::Outside.name(), "outside");
    assert_eq!(PointLocation::OnBoundary.name(), "on");
}
