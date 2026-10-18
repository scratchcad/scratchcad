mod common;

use common::{assert_close, dir, pnt, EPS};
use scratchcad_occt_sys::gp;

#[test]
fn points_vectors_and_directions() {
    let p = pnt(1.0, 2.0, 3.0);
    assert_eq!((p.X(), p.Y(), p.Z()), (1.0, 2.0, 3.0));
    assert_close(p.Distance(&pnt(1.0, 2.0, 8.0)), 5.0, EPS);

    let p2 = gp::new_point_2d(3.0, 4.0);
    assert_eq!((p2.X(), p2.Y()), (3.0, 4.0));
    assert_close(p2.Distance(&gp::new_point_2d(0.0, 0.0)), 5.0, EPS);

    let v = gp::new_vec(3.0, 0.0, 4.0);
    assert_eq!((v.X(), v.Y(), v.Z()), (3.0, 0.0, 4.0));
    assert_close(v.Magnitude(), 5.0, EPS);

    let d = dir(0.0, 3.0, 4.0);
    assert_close(d.X(), 0.0, EPS);
    assert_close(d.Y(), 0.6, EPS);
    assert_close(d.Z(), 0.8, EPS);

    let d2 = gp::gp_Dir2d_new(0.0, 2.0).unwrap();
    assert_eq!((d2.X(), d2.Y()), (0.0, 1.0));
    let _ax2d = gp::gp_Ax2d_new(&p2, &d2);
    let _line = gp::gp_Lin_new(&p, &d);
}

#[test]
fn global_axes() {
    let dz = gp::gp::DZ();
    assert_eq!((dz.X(), dz.Y(), dz.Z()), (0.0, 0.0, 1.0));
    // The axes can be used to build transforms.
    for axis in [gp::gp::OX(), gp::gp::OY(), gp::gp::OZ()] {
        let mut t = gp::new_transform();
        t.pin_mut().SetRotation(axis, std::f64::consts::PI);
        assert_close(t.Value(1, 4).unwrap(), 0.0, EPS);
    }
}

#[test]
fn axis_systems() {
    let ax2 = gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0));
    let x = gp::gp_Ax2_x_direction(&ax2);
    let y = gp::gp_Ax2_y_direction(&ax2);
    assert_close(x.X().abs() + x.Y().abs(), 1.0, EPS);
    assert_close(x.X() * y.X() + x.Y() * y.Y() + x.Z() * y.Z(), 0.0, EPS);

    let custom =
        gp::gp_Ax2_new_with_x_dir(&pnt(1.0, 1.0, 1.0), &dir(0.0, 0.0, 1.0), &dir(0.0, 1.0, 0.0))
            .unwrap();
    let x = gp::gp_Ax2_x_direction(&custom);
    let y = gp::gp_Ax2_y_direction(&custom);
    assert_close(x.Y(), 1.0, EPS);
    assert_close(y.X(), -1.0, EPS);
    let _ax3 = gp::gp_Ax3_from_gp_Ax2(&custom);

    let err =
        gp::gp_Ax2_new_with_x_dir(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0), &dir(0.0, 0.0, 1.0))
            .err()
            .unwrap();
    assert!(err.what().starts_with("Standard_ConstructionError"), "{}", err.what());
}

#[test]
fn circles() {
    let ax2 = gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0));
    assert_eq!(gp::gp_Circ_new(&ax2, 2.5).unwrap().Radius(), 2.5);
    let err = gp::gp_Circ_new(&ax2, -1.0).err().unwrap();
    assert!(err.what().starts_with("Standard_ConstructionError"), "{}", err.what());
}

#[test]
fn transforms_move_points() {
    let mut translate = gp::new_transform();
    translate.pin_mut().SetTranslation(&pnt(0.0, 0.0, 0.0), &pnt(1.0, 2.0, 3.0));
    let mut p = pnt(1.0, 1.0, 1.0);
    p.pin_mut().Transform(&translate);
    assert_eq!((p.X(), p.Y(), p.Z()), (2.0, 3.0, 4.0));
    assert_eq!(translate.Value(2, 4).unwrap(), 2.0);

    let mut by_vec = gp::new_transform();
    by_vec.pin_mut().set_translation_vec(&gp::new_vec(5.0, 0.0, 0.0));
    let mut p = pnt(0.0, 0.0, 0.0);
    p.pin_mut().Transform(&by_vec);
    assert_eq!(p.X(), 5.0);

    let mut rotate = gp::new_transform();
    rotate.pin_mut().SetRotation(gp::gp::OZ(), std::f64::consts::FRAC_PI_2);
    let mut p = pnt(1.0, 0.0, 0.0);
    p.pin_mut().Transform(&rotate);
    assert_close(p.X(), 0.0, EPS);
    assert_close(p.Y(), 1.0, EPS);
    let mut d = dir(1.0, 0.0, 0.0);
    d.pin_mut().Transform(&rotate);
    assert_close(d.Y(), 1.0, EPS);

    let mut scale = gp::new_transform();
    scale.pin_mut().SetScale(&pnt(1.0, 1.0, 1.0), 2.0);
    assert_eq!(scale.ScaleFactor(), 2.0);
    let mut p = pnt(2.0, 1.0, 1.0);
    p.pin_mut().Transform(&scale);
    assert_close(p.X(), 3.0, EPS);

    // Composition: scale, then translate.
    let mut combined = gp::new_transform();
    combined.pin_mut().set_translation_vec(&gp::new_vec(10.0, 0.0, 0.0));
    combined.pin_mut().Multiply(&scale);
    let mut p = pnt(2.0, 1.0, 1.0);
    p.pin_mut().Transform(&combined);
    assert_close(p.X(), 13.0, EPS);
}

#[test]
fn mirror_transforms() {
    let mut point_mirror = gp::new_transform();
    point_mirror.pin_mut().set_mirror_point(&pnt(0.0, 0.0, 0.0));
    let mut p = pnt(1.0, 2.0, 3.0);
    p.pin_mut().Transform(&point_mirror);
    assert_eq!((p.X(), p.Y(), p.Z()), (-1.0, -2.0, -3.0));

    let mut axis_mirror = gp::new_transform();
    axis_mirror.pin_mut().set_mirror_axis(gp::gp::OZ());
    let mut p = pnt(1.0, 2.0, 3.0);
    p.pin_mut().Transform(&axis_mirror);
    assert_close(p.X(), -1.0, EPS);
    assert_close(p.Y(), -2.0, EPS);
    assert_close(p.Z(), 3.0, EPS);

    let mut plane_mirror = gp::new_transform();
    plane_mirror
        .pin_mut()
        .set_mirror_plane(&gp::gp_Ax2_new(&pnt(0.0, 0.0, 1.0), &dir(0.0, 0.0, 1.0)));
    let mut p = pnt(1.0, 2.0, 3.0);
    p.pin_mut().Transform(&plane_mirror);
    assert_close(p.X(), 1.0, EPS);
    assert_close(p.Z(), -1.0, EPS);
}

#[test]
fn matrix_access_is_bounds_checked() {
    let t = gp::new_transform();
    assert_eq!(t.Value(1, 1).unwrap(), 1.0);
    assert_eq!(t.Value(3, 4).unwrap(), 0.0);
    for (row, col) in [(0, 1), (4, 1), (1, 0), (1, 5)] {
        let err = t.Value(row, col).err().unwrap();
        assert!(err.what().starts_with("Standard_OutOfRange"), "{}", err.what());
    }

    let mut g = gp::new_gp_GTrsf();
    g.pin_mut().SetValue(1, 1, 2.0).unwrap();
    assert_eq!(g.Value(1, 1).unwrap(), 2.0);
    assert_eq!(g.Value(2, 2).unwrap(), 1.0);
    assert!(g.pin_mut().SetValue(5, 1, 1.0).is_err());
    assert!(g.Value(1, 9).is_err());
}
