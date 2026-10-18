mod common;

use common::{assert_close, assert_vec_close, err_contains, v};
use scratchcad_occt_rhai::{DVec2, DVec3, Plane, ShapeType, Sketch};
use std::f64::consts::PI;

#[test]
fn drawing_moves_the_pen() {
    let sketch = Sketch::new(Plane::xy());
    assert_eq!(sketch.position(), DVec2::ZERO);
    assert_eq!(sketch.segment_count(), 0);
    let s = sketch
        .move_to(1.0, 1.0)
        .unwrap()
        .line_to(3.0, 1.0)
        .unwrap()
        .line(0.0, 2.0)
        .unwrap()
        .hline(-1.0)
        .unwrap()
        .vline(1.0)
        .unwrap()
        .hline_to(0.0)
        .unwrap()
        .vline_to(0.0)
        .unwrap()
        .polar_line(2.0, 0.0)
        .unwrap();
    assert_eq!(s.segment_count(), 7);
    assert_vec_close(s.position().extend(0.0), v(2.0, 0.0, 0.0), 1e-12);
    assert_eq!(s.to_string(), "Sketch(7 segments, at (2, 0))");
    // The original sketch is unchanged: sketches are values.
    assert_eq!(sketch.segment_count(), 0);
    assert_eq!(sketch.clone(), sketch);
    assert_eq!(s.plane(), Plane::xy());
}

#[test]
fn invalid_segments_are_rejected() {
    let sketch = Sketch::new(Plane::xy()).line_to(1.0, 0.0).unwrap();
    err_contains(sketch.move_to(5.0, 5.0), "move_to is only allowed before drawing");
    err_contains(sketch.line(0.0, 0.0), "zero length");
    err_contains(sketch.line_to(f64::NAN, 0.0), "sketch x");
    err_contains(sketch.line_to(0.0, f64::INFINITY), "sketch y");
    err_contains(sketch.polar_line(1.0, f64::NAN), "angle");
    err_contains(sketch.arc_to(2.0, 0.0, 3.0, 0.0), "collinear");
    err_contains(Sketch::new(Plane::xy()).wire(), "empty sketch");
    err_contains(sketch.close(), "at least 3 lines");
    err_contains(sketch.line_to(0.0, 0.0).unwrap().close(), "at least 3 lines");
    err_contains(Sketch::new(Plane::xy()).close(), "at least 3 lines");
}

#[test]
fn closing_sketches_into_wires_and_faces() {
    let square = Sketch::new(Plane::xy())
        .line_to(2.0, 0.0)
        .unwrap()
        .line_to(2.0, 2.0)
        .unwrap()
        .line_to(0.0, 2.0)
        .unwrap();
    let open = square.wire().unwrap();
    assert!(!open.is_closed());
    assert_close(open.length().unwrap(), 6.0, 1e-9);
    let closed = square.close().unwrap();
    assert!(closed.is_closed());
    assert_eq!(closed.edges().len(), 4);
    let face = square.face().unwrap();
    assert_eq!(face.shape_type(), ShapeType::Face);
    assert_close(face.area().unwrap(), 4.0, 1e-9);

    // Already back at the start: no extra closing segment.
    let explicit = square.line_to(0.0, 0.0).unwrap().close().unwrap();
    assert_eq!(explicit.edges().len(), 4);

    // A "D" shape: a line plus an arc.
    let d =
        Sketch::new(Plane::xy()).move_to(0.0, -1.0).unwrap().arc_to(1.0, 0.0, 0.0, 1.0).unwrap();
    let half_disk = d.face().unwrap();
    assert_close(half_disk.area().unwrap(), PI / 2.0, 1e-9);
}

#[test]
fn sketches_on_other_planes() {
    let plane = Plane::named("XZ").unwrap().offset(-3.0);
    let face = Sketch::new(plane)
        .line_to(1.0, 0.0)
        .unwrap()
        .line_to(1.0, 1.0)
        .unwrap()
        .line_to(0.0, 1.0)
        .unwrap()
        .face()
        .unwrap();
    let center = face.center().unwrap();
    // XZ's normal is -Y, so offsetting by -3 moves the plane to y = +3.
    assert_vec_close(center, v(0.5, 3.0, 0.5), 1e-9);
    assert_vec_close(face.normal().unwrap(), DVec3::NEG_Y, 1e-9);
}
