mod common;

use common::{assert_close, dir, first_subshape, make_box, make_box_at, pnt, EPS};
use scratchcad_occt_sys::{
    b_rep_bnd_lib::BRepBndLib, b_rep_check, b_rep_extrema, b_rep_g_prop, b_rep_int_curve_surface,
    b_rep_prim_api, bnd, g_prop, gp, top_abs::TopAbs_ShapeEnum, topo_ds::TopoDS,
};

#[test]
fn mass_properties() {
    let solid = make_box(2.0, 4.0, 6.0);
    let mut props = g_prop::GProps_new();
    b_rep_g_prop::BRepGProp::VolumeProperties(&solid, props.pin_mut(), false, false, false)
        .unwrap();
    assert_close(props.Mass(), 48.0, EPS);
    let center = g_prop::GProp_GProps_CentreOfMass(&props);
    assert_close(center.X(), 1.0, EPS);
    assert_close(center.Y(), 2.0, EPS);
    assert_close(center.Z(), 3.0, EPS);
    let (mut lx, mut ly, mut lz) = (0.0, 0.0, 0.0);
    props.StaticMoments(&mut lx, &mut ly, &mut lz);
    assert_close(lx, 48.0, EPS);
    assert_close(lz, 144.0, EPS);
    // About the Z axis: m (a^2 + b^2) / 12 + m d^2 with the axis through a corner.
    let axis = gp::gp_Ax1_new(&pnt(1.0, 2.0, 0.0), &dir(0.0, 0.0, 1.0));
    let inertia = props.MomentOfInertia(&axis);
    assert_close(inertia, 48.0 * (4.0 + 16.0) / 12.0, 1e-6);
    assert_close(props.RadiusOfGyration(&axis), (inertia / 48.0).sqrt(), 1e-9);

    let mut surface = g_prop::GProps_new();
    b_rep_g_prop::BRepGProp::SurfaceProperties(&solid, surface.pin_mut(), false, false).unwrap();
    assert_close(surface.Mass(), 2.0 * (8.0 + 12.0 + 24.0), EPS);

    // Every box edge is shared by two faces; without skip_shared each is counted twice.
    let mut linear = g_prop::GProps_new();
    b_rep_g_prop::BRepGProp::LinearProperties(&solid, linear.pin_mut(), false, false).unwrap();
    assert_close(linear.Mass(), 2.0 * 4.0 * (2.0 + 4.0 + 6.0), EPS);
    let mut unique = g_prop::GProps_new();
    b_rep_g_prop::BRepGProp::LinearProperties(&solid, unique.pin_mut(), true, false).unwrap();
    assert_close(unique.Mass(), 4.0 * (2.0 + 4.0 + 6.0), EPS);
}

#[test]
fn face_normals() {
    let solid = make_box(1.0, 1.0, 1.0);
    let face = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_FACE);
    let props = b_rep_g_prop::BRepGProp_Face_new(TopoDS::Face(&face).unwrap()).unwrap();
    let mut point = pnt(0.0, 0.0, 0.0);
    let mut normal = gp::new_vec(0.0, 0.0, 0.0);
    props.Normal(0.5, 0.5, point.pin_mut(), normal.pin_mut()).unwrap();
    assert_close(normal.Magnitude(), 1.0, 1e-6);
    // The first face of a box at the origin is the x = 0 face; its outward normal points to -X.
    assert_close(point.X(), 0.0, EPS);
    assert!(normal.X() < 0.0);
}

#[test]
fn bounding_boxes() {
    let mut empty = bnd::Bnd_Box_new();
    assert!(empty.IsVoid());
    let (mut a, mut b, mut c, mut d, mut e, mut f) = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    let err = empty.Get(&mut a, &mut b, &mut c, &mut d, &mut e, &mut f).err().unwrap();
    assert!(err.what().starts_with("Standard_ConstructionError"), "{}", err.what());
    assert!(bnd::Bnd_Box_CornerMin(&empty).is_err());
    assert!(bnd::Bnd_Box_CornerMax(&empty).is_err());
    empty.pin_mut().Set(&pnt(1.0, 2.0, 3.0)).unwrap();
    assert!(!empty.IsVoid());
    empty.pin_mut().SetGap(0.5);
    assert_eq!(empty.GetGap(), 0.5);
    let min = bnd::Bnd_Box_CornerMin(&empty).unwrap();
    assert_close(min.X(), 0.5, EPS);

    let mut sphere = b_rep_prim_api::BRepPrimAPI_MakeSphere_new(
        &gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0)),
        1.0,
        std::f64::consts::TAU,
    )
    .unwrap();
    let sphere = sphere.pin_mut().Shape().unwrap();
    let mut optimal = bnd::Bnd_Box_new();
    BRepBndLib::AddOptimal(sphere, optimal.pin_mut(), false, false).unwrap();
    optimal.Get(&mut a, &mut b, &mut c, &mut d, &mut e, &mut f).unwrap();
    assert_close(a, -1.0, 1e-6);
    assert_close(f, 1.0, 1e-6);

    let mut quick = bnd::Bnd_Box_new();
    BRepBndLib::Add(sphere, quick.pin_mut(), false).unwrap();
    let max = bnd::Bnd_Box_CornerMax(&quick).unwrap();
    // The fast box is never smaller than the exact one.
    assert!(max.X() >= 1.0 - 1e-9);
}

#[test]
fn validity_checks() {
    let solid = make_box(1.0, 1.0, 1.0);
    assert!(b_rep_check::BRepCheck_Analyzer_new(&solid).unwrap().IsValid());
}

#[test]
fn distances() {
    let a = make_box(1.0, 1.0, 1.0);
    let b = make_box_at(3.0, 0.0, 0.0, 1.0, 1.0, 1.0);
    let dist = b_rep_extrema::BRepExtrema_DistShapeShape_new(&a, &b).unwrap();
    assert!(dist.IsDone());
    assert_close(dist.Value().unwrap(), 2.0, EPS);
    assert!(dist.NbSolution() >= 1);
    let p1 = b_rep_extrema::BRepExtrema_DistShapeShape_point_on_shape_1(&dist, 1).unwrap();
    let p2 = b_rep_extrema::BRepExtrema_DistShapeShape_point_on_shape_2(&dist, 1).unwrap();
    assert_close(p1.X(), 1.0, EPS);
    assert_close(p2.X(), 3.0, EPS);

    let touching = make_box_at(1.0, 0.0, 0.0, 1.0, 1.0, 1.0);
    let dist = b_rep_extrema::BRepExtrema_DistShapeShape_new(&a, &touching).unwrap();
    assert_close(dist.Value().unwrap(), 0.0, EPS);
}

#[test]
fn line_intersections() {
    let solid = make_box(2.0, 2.0, 2.0);
    let line = gp::gp_Lin_new(&pnt(1.0, 1.0, -5.0), &dir(0.0, 0.0, 1.0));
    let mut inter = b_rep_int_curve_surface::BRepIntCurveSurface_Inter_new();
    inter.pin_mut().Init(&solid, &line, 1e-7).unwrap();
    let mut hits = Vec::new();
    while inter.More() {
        let point = b_rep_int_curve_surface::BRepIntCurveSurface_Inter_point(&inter).unwrap();
        let face = b_rep_int_curve_surface::BRepIntCurveSurface_Inter_face(&inter).unwrap();
        assert!(!scratchcad_occt_sys::topo_ds::cast_face_to_shape(&face).IsNull());
        assert!(inter.U().is_finite() && inter.V().is_finite());
        hits.push((point.Z(), inter.W()));
        inter.pin_mut().Next();
    }
    hits.sort_by(|a, b| a.0.total_cmp(&b.0));
    assert_eq!(hits.len(), 2);
    assert_close(hits[0].0, 0.0, EPS);
    assert_close(hits[1].0, 2.0, EPS);
    // W is the parameter along the line, measured from its origin at z = -5.
    assert_close(hits[0].1, 5.0, EPS);
}
