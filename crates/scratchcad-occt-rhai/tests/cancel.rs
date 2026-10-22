//! Stopping OpenCASCADE algorithms through a `CancelToken`.

mod common;

use common::{assert_close, cube10, temp_dir, v};
use scratchcad_occt_rhai::{
    engine, error_kind, with_cancel, CancelToken, Error, ErrorKind, Format, MeshOptions, Shape,
};
use std::time::{Duration, Instant};

fn circle(z: f64) -> Shape {
    Shape::circle(v(0.0, 0.0, z), v(0.0, 0.0, 1.0), 2.0).unwrap()
}

fn cancelled() -> CancelToken {
    let token = CancelToken::new();
    token.cancel();
    token
}

#[track_caller]
fn assert_cancelled<T: std::fmt::Debug>(result: Result<T, Error>) {
    assert!(matches!(result, Err(Error::Cancelled)), "expected Cancelled, got {result:?}");
}

#[test]
fn operations_stop_when_already_cancelled() {
    let a = cube10();
    let b = Shape::sphere(6.0).unwrap();
    let step = a.to_step().unwrap();
    let brep = a.to_brep().unwrap();
    let dir = temp_dir();
    let iges = dir.path().join("a.igs");
    a.write_iges(&iges).unwrap();
    let token = cancelled();
    with_cancel(&token, || {
        assert_cancelled(a.fuse(&b));
        assert_cancelled(a.cut(&b));
        assert_cancelled(a.common(&b));
        assert_cancelled(a.section(&b));
        assert_cancelled(a.fillet_all(1.0));
        assert_cancelled(a.chamfer_all(1.0));
        assert_cancelled(a.shell(-1.0, a.faces().select(">Z").unwrap().shapes()));
        assert_cancelled(a.clean());
        assert_cancelled(Shape::loft(&[circle(0.0), circle(5.0)], true));
        assert_cancelled(
            Shape::circle(v(0.0, 0.0, 0.0), v(0.0, 0.0, 1.0), 1.0)
                .unwrap()
                .sweep(&Shape::line(v(0.0, 0.0, 0.0), v(0.0, 0.0, 5.0)).unwrap()),
        );
        assert_cancelled(a.mesh(0.1));
        assert_cancelled(a.to_step());
        assert_cancelled(a.to_iges());
        assert_cancelled(a.to_brep());
        assert_cancelled(Shape::from_step(&step));
        assert_cancelled(Shape::from_brep(&brep));
        assert_cancelled(Shape::read_iges(&iges));
    });
}

#[test]
fn operations_run_normally_under_a_live_token() {
    let token = CancelToken::new();
    // The sphere is off the cube's faces: centred on its corner, the sphere's seam lies in one
    // of them, and OpenCASCADE's cut then removed nothing.
    let volume = with_cancel(&token, || {
        let ball = Shape::sphere_at(v(0.1, 0.2, 0.3), 6.0).unwrap();
        let part = cube10().fillet_all(0.5)?.cut(&ball)?;
        let bytes = part.to_bytes(Format::Step, &MeshOptions::new(0.1))?;
        Shape::from_step(&bytes)?.volume()
    })
    .unwrap();
    assert!(volume > 800.0 && volume < 900.0, "{volume}");
    assert!(!token.is_cancelled());
}

#[test]
fn cancelling_from_another_thread_stops_meshing() {
    // Meshing stops between faces, so mesh many faces: unstopped, this takes many seconds.
    let spheres: Vec<Shape> =
        (0..400).map(|i| Shape::sphere_at(v(3.0 * i as f64, 0.0, 0.0), 1.0).unwrap()).collect();
    let sphere = Shape::compound(&spheres).unwrap();
    let options = MeshOptions::new(1e-4);
    let token = CancelToken::new();
    let remote = token.clone();
    let canceller = std::thread::spawn(move || {
        std::thread::sleep(Duration::from_millis(200));
        remote.cancel();
    });
    let start = Instant::now();
    let result = with_cancel(&token, || sphere.mesh_with(&options));
    let elapsed = start.elapsed();
    canceller.join().unwrap();
    assert_cancelled(result);
    assert!(elapsed < Duration::from_secs(5), "took {elapsed:?}");
}

#[test]
fn scripts_report_cancellation() {
    let token = cancelled();
    let error =
        with_cancel(&token, || engine().eval::<Shape>("box(10, 10, 10).fillet(1)")).unwrap_err();
    assert_eq!(error_kind(&error), Some(ErrorKind::Cancelled));
    assert!(error.to_string().contains("cancelled"), "{error}");

    // Outside the scope the same script works.
    let volume: f64 = engine().eval("box(10, 10, 10).fillet(1).volume()").unwrap();
    assert!(volume < 1000.0);
}

#[test]
fn tokens_only_apply_inside_their_scope() {
    let token = cancelled();
    with_cancel(&token, || {});
    assert_close(cube10().fuse(&cube10()).unwrap().volume().unwrap(), 1000.0, 1e-6);
}
