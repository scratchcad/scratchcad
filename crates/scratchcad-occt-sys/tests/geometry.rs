mod common;

use common::{assert_close, dir, first_subshape, length, make_box, pnt, subshapes, EPS};
use scratchcad_occt_sys::{
    b_rep, b_rep_adaptor as adaptor, b_rep_builder_api as bb, gc, gc_pnts, geom, geom2d,
    geom_abs::{GeomAbs_CurveType, GeomAbs_SurfaceType},
    geom_api, gp, law, standard, t_col_gp,
    top_abs::TopAbs_ShapeEnum,
    topo_ds::{self, TopoDS},
};
use std::f64::consts::PI;

fn points_array(
    points: &[(f64, f64, f64)],
) -> cxx::UniquePtr<t_col_gp::Handle_TColgp_HArray1OfPnt> {
    let mut array = t_col_gp::TColgp_HArray1OfPnt_new(1, points.len() as i32).unwrap();
    for (i, p) in points.iter().enumerate() {
        array.pin_mut().SetValue(i as i32 + 1, &pnt(p.0, p.1, p.2)).unwrap();
    }
    assert_eq!(array.Length(), points.len() as i32);
    let second = t_col_gp::TColgp_HArray1OfPnt_Value(&array, 2).unwrap();
    assert_eq!(second.X(), points[1].0);
    t_col_gp::new_HandleTColgpHArray1OfPnt_from_TColgpHArray1OfPnt(array)
}

#[test]
fn interpolated_splines() {
    let points = points_array(&[(0.0, 0.0, 0.0), (1.0, 1.0, 0.0), (2.0, 0.0, 0.0)]);
    let mut interpolate = geom_api::GeomAPI_Interpolate_new(&points, false, 1e-7).unwrap();
    interpolate.pin_mut().Perform().unwrap();
    let curve = geom_api::GeomAPI_Interpolate_Curve(&interpolate).unwrap();
    assert!(!curve.IsNull());
    let curve = geom::new_HandleGeomCurve_from_HandleGeom_BSplineCurve(&curve);
    assert!(!curve.IsNull());
    let start = geom::HandleGeomCurve_Value(&curve, 0.0).unwrap();
    assert_close(start.X(), 0.0, EPS);

    // With explicit end tangents.
    let mut tangent = geom_api::GeomAPI_Interpolate_new(&points, false, 1e-7).unwrap();
    tangent
        .pin_mut()
        .Load(&gp::new_vec(0.0, 1.0, 0.0), &gp::new_vec(0.0, -1.0, 0.0), true)
        .unwrap();
    tangent.pin_mut().Perform().unwrap();
    assert!(geom_api::GeomAPI_Interpolate_Curve(&tangent).is_ok());

    // Without Perform there is no curve.
    let not_performed = geom_api::GeomAPI_Interpolate_new(&points, false, 1e-7).unwrap();
    assert!(geom_api::GeomAPI_Interpolate_Curve(&not_performed).is_err());
}

#[test]
fn bezier_curves_and_trimmed_curves() {
    let mut poles = t_col_gp::TColgp_HArray1OfPnt_new(1, 3).unwrap();
    poles.pin_mut().SetValue(1, &pnt(0.0, 0.0, 0.0)).unwrap();
    poles.pin_mut().SetValue(2, &pnt(1.0, 2.0, 0.0)).unwrap();
    poles.pin_mut().SetValue(3, &pnt(2.0, 0.0, 0.0)).unwrap();
    let bezier =
        geom::Geom_BezierCurve_to_handle(geom::Geom_BezierCurve_new_points(&poles).unwrap());
    assert!(!bezier.IsNull());
    let curve = geom::new_HandleGeomCurve_from_HandleGeom_BezierCurve(&bezier);
    let middle = geom::HandleGeomCurve_Value(&curve, 0.5).unwrap();
    assert_close(middle.Y(), 1.0, EPS);

    let arc = gc::GC_MakeArcOfCircle_point_point_point(
        &pnt(1.0, 0.0, 0.0),
        &pnt(0.0, 1.0, 0.0),
        &pnt(-1.0, 0.0, 0.0),
    )
    .unwrap();
    let trimmed = gc::GC_MakeArcOfCircle_Value(&arc).unwrap();
    assert!(!trimmed.IsNull());
    let curve = geom::new_HandleGeomCurve_from_HandleGeom_TrimmedCurve(&trimmed);
    let mut edge = bb::BRepBuilderAPI_MakeEdge_HandleGeomCurve(&curve).unwrap();
    assert_close(length(topo_ds::cast_edge_to_shape(edge.pin_mut().Edge().unwrap())), PI, 1e-6);
}

#[test]
fn surfaces_and_planes() {
    let solid = make_box(2.0, 2.0, 2.0);
    let face = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_FACE);
    let surface = b_rep::BRep_Tool_Surface(TopoDS::Face(&face).unwrap()).unwrap();
    assert!(!surface.IsNull());
    let surface_type = geom::DynamicType(&surface).unwrap();
    assert!(!surface_type.IsNull());
    assert_eq!(standard::type_name(surface_type).unwrap(), "Geom_Plane");
    let plane = geom::new_HandleGeomPlane_from_HandleGeomSurface(&surface);
    assert!(!plane.IsNull());
    let _location = geom::handle_geom_plane_location(&plane).unwrap();

    let projector =
        geom_api::GeomAPI_ProjectPointOnSurf_new(&pnt(0.0, 1.0, 1.0), &surface).unwrap();
    assert!(projector.NbPoints() >= 1);
    let (mut u, mut v) = (f64::NAN, f64::NAN);
    geom_api::GeomAPI_ProjectPointOnSurf_LowerDistanceParameters(&projector, &mut u, &mut v)
        .unwrap();
    assert!(u.is_finite() && v.is_finite());

    let axis = gp::gp_Ax3_from_gp_Ax2(&gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0)));
    let cylinder = geom::Geom_CylindricalSurface_new(&axis, 2.0).unwrap();
    assert!(!cylinder.IsNull());
    assert!(geom::Geom_CylindricalSurface_new(&axis, -1.0).is_err());
    let surface = geom::cylinder_to_surface(&cylinder);
    let projector =
        geom_api::GeomAPI_ProjectPointOnSurf_new(&pnt(5.0, 0.0, 3.0), &surface).unwrap();
    geom_api::GeomAPI_ProjectPointOnSurf_LowerDistanceParameters(&projector, &mut u, &mut v)
        .unwrap();
    assert_close(u, 0.0, 1e-9);
    assert_close(v, 3.0, 1e-9);

    let mut poles = t_col_gp::TColgp_Array2OfPnt_new(1, 2, 1, 2).unwrap();
    for (r, c, x, y) in [(1, 1, 0.0, 0.0), (1, 2, 0.0, 1.0), (2, 1, 1.0, 0.0), (2, 2, 1.0, 1.0)] {
        poles.pin_mut().SetValue(r, c, &pnt(x, y, 0.0)).unwrap();
    }
    assert!(poles.pin_mut().SetValue(3, 1, &pnt(0.0, 0.0, 0.0)).is_err());
    let bezier = geom::Geom_BezierSurface_new(&poles).unwrap();
    assert!(!bezier.IsNull());
    assert!(!geom::bezier_to_surface(&bezier).IsNull());
}

#[test]
fn curves_in_2d() {
    let axis = gp::gp_Ax2d_new(&gp::new_point_2d(0.0, 0.0), &gp::gp_Dir2d_new(1.0, 0.0).unwrap());
    let ellipse = geom2d::Geom2d_Ellipse_new(&axis, 3.0, 1.0).unwrap();
    assert!(!ellipse.IsNull());
    let p = geom2d::ellipse_value(&ellipse, 0.0).unwrap();
    assert_close(p.X(), 3.0, EPS);
    assert!(
        geom2d::Geom2d_Ellipse_new(&axis, 1.0, 3.0).is_err(),
        "minor radius must not exceed major"
    );

    let curve = geom2d::ellipse_to_HandleGeom2d_Curve(&ellipse);
    assert!(!curve.IsNull());
    let trimmed = geom2d::Geom2d_TrimmedCurve_new(&curve, 0.0, PI).unwrap();
    assert!(!trimmed.IsNull());
    assert!(!geom2d::HandleGeom2d_TrimmedCurve_to_curve(&trimmed).IsNull());

    let segment =
        gc::GCE2d_MakeSegment_point_point(&gp::new_point_2d(0.0, 0.0), &gp::new_point_2d(1.0, 1.0))
            .unwrap();
    assert!(!segment.IsNull());
}

#[test]
fn edge_and_face_adaptors() {
    let mut circle_edge = bb::BRepBuilderAPI_MakeEdge_circle(
        &gp::gp_Circ_new(&gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0)), 3.0).unwrap(),
    )
    .unwrap();
    let edge = circle_edge.pin_mut().Edge().unwrap();
    let curve = adaptor::BRepAdaptor_Curve_new(edge).unwrap();
    assert_eq!(curve.GetType(), GeomAbs_CurveType::GeomAbs_Circle);
    assert!(curve.IsClosed());
    assert_close(curve.LastParameter() - curve.FirstParameter(), 2.0 * PI, EPS);
    assert_close(adaptor::BRepAdaptor_Curve_circle(&curve).unwrap().Radius(), 3.0, EPS);
    let p = adaptor::BRepAdaptor_Curve_value(&curve, 0.0).unwrap();
    assert_close(p.X(), 3.0, EPS);
    let mut point = pnt(0.0, 0.0, 0.0);
    let mut tangent = gp::new_vec(0.0, 0.0, 0.0);
    curve.D1(0.0, point.pin_mut(), tangent.pin_mut()).unwrap();
    assert_close(tangent.Y(), 3.0, EPS);

    let mut deflection = gc_pnts::TangentialDeflection_new(&curve, 0.1, 0.01).unwrap();
    let n = deflection.NbPoints();
    assert!(n > 8, "{n}");
    let first = gc_pnts::GCPnts_TangentialDeflection_Value(&deflection, 1).unwrap();
    assert_close(first.Distance(&pnt(0.0, 0.0, 0.0)), 3.0, 1e-6);
    assert!(gc_pnts::GCPnts_TangentialDeflection_Value(&deflection, n + 1).is_err());
    let _ = deflection.pin_mut();

    let mut first = 0.0;
    let mut last = 0.0;
    let handle = b_rep::BRep_Tool_Curve(edge, &mut first, &mut last).unwrap();
    assert!(!handle.IsNull());
    assert_close(last - first, 2.0 * PI, EPS);

    let solid = make_box(1.0, 2.0, 3.0);
    let line = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_EDGE);
    let curve = adaptor::BRepAdaptor_Curve_new(TopoDS::Edge(&line).unwrap()).unwrap();
    assert_eq!(curve.GetType(), GeomAbs_CurveType::GeomAbs_Line);
    assert!(!curve.IsClosed());

    let faces = subshapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE);
    let surface = adaptor::BRepAdaptor_Surface_new(TopoDS::Face(&faces[0]).unwrap(), true).unwrap();
    assert_eq!(surface.GetType(), GeomAbs_SurfaceType::GeomAbs_Plane);
    let (u0, u1) = (surface.FirstUParameter(), surface.LastUParameter());
    let (v0, v1) = (surface.FirstVParameter(), surface.LastVParameter());
    assert!(u1 > u0 && v1 > v0);
    let p = adaptor::BRepAdaptor_Surface_value(&surface, u0, v0).unwrap();
    assert!(p.X().is_finite());

    let mut cylinder = scratchcad_occt_sys::b_rep_prim_api::BRepPrimAPI_MakeCylinder_new(
        &gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0)),
        1.0,
        1.0,
    )
    .unwrap();
    let cylinder = topo_ds::TopoDS_Shape_to_owned(cylinder.pin_mut().Shape().unwrap());
    let kinds: Vec<_> = subshapes(&cylinder, TopAbs_ShapeEnum::TopAbs_FACE)
        .iter()
        .map(|f| {
            adaptor::BRepAdaptor_Surface_new(TopoDS::Face(f).unwrap(), false).unwrap().GetType()
        })
        .collect();
    assert!(kinds.contains(&GeomAbs_SurfaceType::GeomAbs_Cylinder));
    assert!(kinds.contains(&GeomAbs_SurfaceType::GeomAbs_Plane));
}

#[test]
fn interpolation_laws() {
    let mut points = t_col_gp::TColgp_Array1OfPnt2d_new(1, 3).unwrap();
    assert_eq!(points.Length(), 3);
    for (i, (x, y)) in [(0.0, 1.0), (0.5, 3.0), (1.0, 2.0)].into_iter().enumerate() {
        points.pin_mut().SetValue(i as i32 + 1, &gp::new_point_2d(x, y)).unwrap();
    }
    assert_eq!(t_col_gp::TColgp_Array1OfPnt2d_Value(&points, 2).unwrap().Y(), 3.0);
    assert!(t_col_gp::TColgp_Array1OfPnt2d_Value(&points, 4).is_err());
    let mut interpol = law::Law_Interpol_new();
    interpol.pin_mut().Set(&points, false).unwrap();
    let handle = law::Law_Function_to_handle(law::Law_Interpol_into_Law_Function(interpol));
    assert!(!handle.IsNull());

    let dirs = t_col_gp::TColgp_Array1OfDir_new(1, 2).unwrap();
    assert_eq!(dirs.Length(), 2);
    assert!(t_col_gp::TColgp_Array1OfDir_Value(&dirs, 1).is_ok());
    assert!(t_col_gp::TColgp_Array1OfDir_Value(&dirs, 3).is_err());
}
