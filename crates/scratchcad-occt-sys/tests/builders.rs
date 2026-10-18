mod common;

use common::{area, assert_close, dir, length, make_box, pnt, progress, unique_count, volume, EPS};
use scratchcad_occt_sys::{
    b_rep_builder_api as bb,
    b_rep_lib::BRepLib,
    gc, geom, gp, poly,
    top_abs::TopAbs_ShapeEnum,
    topo_ds::{self, TopoDS},
};

fn edge(a: (f64, f64, f64), b: (f64, f64, f64)) -> cxx::UniquePtr<topo_ds::TopoDS_Edge> {
    let mut make =
        bb::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&pnt(a.0, a.1, a.2), &pnt(b.0, b.1, b.2))
            .unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    topo_ds::TopoDS_Edge_to_owned(make.pin_mut().Edge().unwrap())
}

fn square_wire(size: f64, offset: f64) -> cxx::UniquePtr<topo_ds::TopoDS_Wire> {
    let (a, b) = (offset, offset + size);
    let mut make = bb::BRepBuilderAPI_MakeWire_new();
    make.pin_mut().add_edge(&edge((a, a, 0.0), (b, a, 0.0))).unwrap();
    make.pin_mut().add_edge(&edge((b, a, 0.0), (b, b, 0.0))).unwrap();
    make.pin_mut().add_edge(&edge((b, b, 0.0), (a, b, 0.0))).unwrap();
    make.pin_mut().add_edge(&edge((a, b, 0.0), (a, a, 0.0))).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    topo_ds::TopoDS_Wire_to_owned(make.pin_mut().Wire().unwrap())
}

#[test]
fn vertices() {
    let mut make = bb::BRepBuilderAPI_MakeVertex_gp_Pnt(&pnt(1.0, 2.0, 3.0)).unwrap();
    let vertex = make.pin_mut().Vertex().unwrap();
    let p = scratchcad_occt_sys::b_rep::BRep_Tool_Pnt(vertex).unwrap();
    assert_eq!((p.X(), p.Y(), p.Z()), (1.0, 2.0, 3.0));
}

#[test]
fn edges_from_points_circles_and_curves() {
    let line = edge((0.0, 0.0, 0.0), (3.0, 4.0, 0.0));
    assert_close(length(topo_ds::cast_edge_to_shape(&line)), 5.0, EPS);

    let mut make =
        bb::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&pnt(0.0, 0.0, 0.0), &pnt(1.0, 0.0, 0.0))
            .unwrap();
    let v1 = scratchcad_occt_sys::b_rep::BRep_Tool_Pnt(make.Vertex1().unwrap()).unwrap();
    assert_eq!(v1.X(), 0.0);
    assert!(make.pin_mut().Edge().is_ok());

    let circle =
        gp::gp_Circ_new(&gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0)), 2.0).unwrap();
    let mut make = bb::BRepBuilderAPI_MakeEdge_circle(&circle).unwrap();
    assert!(make.IsDone());
    let circle_edge = topo_ds::cast_edge_to_shape(make.pin_mut().Edge().unwrap());
    assert_close(length(circle_edge), 4.0 * std::f64::consts::PI, 1e-6);

    let segment = gc::GC_MakeSegment_point_point(&pnt(0.0, 0.0, 0.0), &pnt(0.0, 0.0, 7.0)).unwrap();
    let curve = geom::new_HandleGeomCurve_from_HandleGeom_TrimmedCurve(
        &gc::GC_MakeSegment_Value(&segment).unwrap(),
    );
    let mut make = bb::BRepBuilderAPI_MakeEdge_HandleGeomCurve(&curve).unwrap();
    assert_close(length(topo_ds::cast_edge_to_shape(make.pin_mut().Edge().unwrap())), 7.0, EPS);
}

#[test]
fn edge_on_a_surface_from_a_2d_curve() {
    let axis = gp::gp_Ax3_from_gp_Ax2(&gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0)));
    let cylinder = geom::Geom_CylindricalSurface_new(&axis, 1.0).unwrap();
    let surface = geom::cylinder_to_surface(&cylinder);
    // A straight line in (u, v) space along v is a vertical line on the cylinder.
    let segment = scratchcad_occt_sys::gc::GCE2d_MakeSegment_point_point(
        &gp::new_point_2d(0.0, 0.0),
        &gp::new_point_2d(0.0, 3.0),
    )
    .unwrap();
    let curve_2d = scratchcad_occt_sys::geom2d::HandleGeom2d_TrimmedCurve_to_curve(&segment);
    let mut make = bb::BRepBuilderAPI_MakeEdge_CurveSurface2d(&curve_2d, &surface).unwrap();
    assert!(make.IsDone());
    let edge = topo_ds::TopoDS_Edge_to_owned(make.pin_mut().Edge().unwrap());
    let edge_shape = topo_ds::cast_edge_to_shape(&edge);
    assert!(BRepLib::BuildCurves3d(edge_shape).unwrap());
    assert_close(length(edge_shape), 3.0, 1e-6);
}

#[test]
fn wires() {
    let wire = square_wire(2.0, 0.0);
    assert_close(length(topo_ds::cast_wire_to_shape(&wire)), 8.0, EPS);

    let e1 = edge((0.0, 0.0, 0.0), (1.0, 0.0, 0.0));
    let e2 = edge((1.0, 0.0, 0.0), (1.0, 1.0, 0.0));
    let e3 = edge((1.0, 1.0, 0.0), (0.0, 0.0, 0.0));
    let mut two = bb::BRepBuilderAPI_MakeWire_edge_edge(&e1, &e2).unwrap();
    assert!(two.IsDone());
    let two = topo_ds::TopoDS_Wire_to_owned(two.pin_mut().Wire().unwrap());
    let mut three = bb::BRepBuilderAPI_MakeWire_edge_edge_edge(&e1, &e2, &e3).unwrap();
    assert_eq!(unique_count(three.pin_mut().Shape().unwrap(), TopAbs_ShapeEnum::TopAbs_EDGE), 3);

    let mut combined = bb::BRepBuilderAPI_MakeWire_new();
    combined.pin_mut().add_wire(&two).unwrap();
    combined.pin_mut().add_edge(&e3).unwrap();
    assert!(combined.IsDone());
    assert!(scratchcad_occt_sys::b_rep::BRep_Tool::IsClosed(combined.pin_mut().Shape().unwrap()));

    // Disconnected edges cannot form a wire.
    let far = edge((10.0, 10.0, 10.0), (11.0, 10.0, 10.0));
    let mut broken = bb::BRepBuilderAPI_MakeWire_edge_edge(&e1, &far).unwrap();
    assert!(!broken.IsDone());
    let err = broken.pin_mut().Wire().err().unwrap();
    assert!(err.what().starts_with("StdFail_NotDone"), "{}", err.what());
}

#[test]
fn faces_from_wires_and_surfaces() {
    let outer = square_wire(4.0, 0.0);
    let mut make = bb::BRepBuilderAPI_MakeFace_wire(&outer, true).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    assert_close(area(make.pin_mut().Shape().unwrap()), 16.0, 1e-6);
    let inner = square_wire(2.0, 1.0);
    make.pin_mut().add_wire(&inner).unwrap();
    let face = make.Face().unwrap();
    assert_eq!(unique_count(topo_ds::cast_face_to_shape(face), TopAbs_ShapeEnum::TopAbs_WIRE), 2);

    // A bezier surface patch.
    let mut poles = scratchcad_occt_sys::t_col_gp::TColgp_Array2OfPnt_new(1, 2, 1, 2).unwrap();
    poles.pin_mut().SetValue(1, 1, &pnt(0.0, 0.0, 0.0)).unwrap();
    poles.pin_mut().SetValue(1, 2, &pnt(0.0, 1.0, 0.0)).unwrap();
    poles.pin_mut().SetValue(2, 1, &pnt(1.0, 0.0, 0.0)).unwrap();
    poles.pin_mut().SetValue(2, 2, &pnt(1.0, 1.0, 0.0)).unwrap();
    let bezier = geom::Geom_BezierSurface_new(&poles).unwrap();
    let surface = geom::bezier_to_surface(&bezier);
    let mut make = bb::BRepBuilderAPI_MakeFace_surface(&surface, 1e-6).unwrap();
    assert!(make.IsDone());
    assert_close(area(make.pin_mut().Shape().unwrap()), 1.0, 1e-6);
}

#[test]
fn shape_from_a_triangle_mesh() {
    let mut triangulation = poly::Triangulation_new(3, 1, false, false);
    triangulation.pin_mut().SetNode(1, &pnt(0.0, 0.0, 0.0)).unwrap();
    triangulation.pin_mut().SetNode(2, &pnt(2.0, 0.0, 0.0)).unwrap();
    triangulation.pin_mut().SetNode(3, &pnt(0.0, 2.0, 0.0)).unwrap();
    triangulation.pin_mut().SetTriangle(1, &poly::Triangle_new(1, 2, 3)).unwrap();
    let handle = poly::Handle_Poly_Triangulation_new(triangulation);
    let mut make = bb::BRepBuilderAPI_MakeShapeOnMesh_new(&handle).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    let shape = make.pin_mut().Shape().unwrap();
    assert_eq!(unique_count(shape, TopAbs_ShapeEnum::TopAbs_FACE), 1);
    assert_close(area(shape), 2.0, 1e-6);
}

#[test]
fn transforms() {
    let solid = make_box(1.0, 1.0, 1.0);
    let mut t = gp::new_transform();
    t.pin_mut().set_translation_vec(&gp::new_vec(0.0, 0.0, 5.0));
    let mut make = bb::BRepBuilderAPI_Transform_new(&solid, &t, true).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    let moved = make.pin_mut().Shape().unwrap();
    let mut props = scratchcad_occt_sys::g_prop::GProps_new();
    scratchcad_occt_sys::b_rep_g_prop::BRepGProp::VolumeProperties(
        moved,
        props.pin_mut(),
        false,
        false,
        false,
    )
    .unwrap();
    assert_close(scratchcad_occt_sys::g_prop::GProp_GProps_CentreOfMass(&props).Z(), 5.5, EPS);

    // A non-uniform scale doubles x.
    let mut g = gp::new_gp_GTrsf();
    g.pin_mut().SetValue(1, 1, 2.0).unwrap();
    let mut make = bb::BRepBuilderAPI_GTransform_new(&solid, &g, true).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    assert_close(volume(make.pin_mut().Shape().unwrap()), 2.0, 1e-6);

    assert!(TopoDS::Solid(&solid).is_ok());
}
