//! Moving shapes between threads, and copies that share nothing.

mod common;

use common::{assert_close, assert_vec_close, cube10, v};
use scratchcad_occt_rhai::{DetachedShape, Shape};

fn assert_send<T: Send>() {}

#[test]
fn detached_shapes_can_move_between_threads() {
    assert_send::<DetachedShape>();
    let part = cube10().cut(&Shape::sphere(6.0).unwrap()).unwrap();
    let volume = part.volume().unwrap();
    let detached = part.detach().unwrap();
    assert_eq!(format!("{detached:?}"), "DetachedShape");
    let (moved_volume, back) = std::thread::spawn(move || {
        let shape = detached.attach();
        let moved = shape.translate(v(1.0, 0.0, 0.0)).unwrap();
        (moved.volume().unwrap(), moved.detach().unwrap())
    })
    .join()
    .unwrap();
    assert_close(moved_volume, volume, 1e-6);
    let back = back.attach();
    assert_close(back.bounding_box().unwrap().min.x, 1.0, 1e-6);
    // The original is untouched.
    assert_close(part.volume().unwrap(), volume, 1e-9);
}

#[test]
fn shapes_on_many_threads() {
    let parts: Vec<_> = (1..=4)
        .map(|i| Shape::cube(i as f64).unwrap().fillet_all(0.1).unwrap().detach().unwrap())
        .collect();
    let volumes: Vec<f64> = parts
        .into_iter()
        .map(|detached| {
            std::thread::spawn(move || {
                let shape = detached.attach();
                shape.mesh(0.01).unwrap();
                shape.volume().unwrap()
            })
        })
        .map(|handle| handle.join().unwrap())
        .collect();
    for (i, volume) in volumes.into_iter().enumerate() {
        let side = (i + 1) as f64;
        assert!(volume < side.powi(3) && volume > 0.9 * side.powi(3), "{volume}");
    }
}

#[test]
fn deep_copies_share_nothing() {
    let part = cube10();
    let copy = part.deep_copy().unwrap();
    assert!(!copy.is_same(&part));
    assert!(copy.faces().iter().all(|face| !part.faces().iter().any(|f| f.is_same(face))));
    assert_close(copy.volume().unwrap(), 1000.0, 1e-9);
    // Sub-shapes keep their exploration order.
    for (a, b) in part.faces().iter().zip(copy.faces().iter()) {
        assert_vec_close(a.center().unwrap(), b.center().unwrap(), 1e-12);
    }
}

#[test]
fn booleans_leave_their_arguments_unchanged() {
    let a = cube10();
    let b = Shape::sphere(6.0).unwrap();
    let tolerance_before = a.to_brep().unwrap();
    a.fuse(&b).unwrap();
    a.cut(&b).unwrap();
    a.common(&b).unwrap();
    // The BREP text includes every tolerance, so any in-place update would show.
    assert_eq!(a.to_brep().unwrap(), tolerance_before);
}
