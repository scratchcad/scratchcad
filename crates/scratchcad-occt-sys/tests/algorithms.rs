mod common;

use common::{
    area, assert_close, dir, first_subshape, length, make_box, make_box_at, pnt, progress,
    subshapes, unique_count, volume,
};
use scratchcad_occt_sys::{
    b_rep_algo_api as algo, b_rep_builder_api as bb, b_rep_feat, b_rep_fillet_api as fillet,
    b_rep_offset_api as offset, b_rep_prim_api as prim,
    bop_algo::BOPAlgo_GlueEnum,
    geom_abs::GeomAbs_JoinType,
    gp, law, shape_analysis, shape_upgrade, t_col_gp,
    top_abs::TopAbs_ShapeEnum,
    top_tools,
    topo_ds::{self, TopoDS},
};
use std::f64::consts::PI;

type Shape = cxx::UniquePtr<topo_ds::TopoDS_Shape>;

fn owned(shape: &topo_ds::TopoDS_Shape) -> Shape {
    topo_ds::TopoDS_Shape_to_owned(shape)
}

fn edge(a: (f64, f64, f64), b: (f64, f64, f64)) -> cxx::UniquePtr<topo_ds::TopoDS_Edge> {
    let mut make =
        bb::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&pnt(a.0, a.1, a.2), &pnt(b.0, b.1, b.2))
            .unwrap();
    topo_ds::TopoDS_Edge_to_owned(make.pin_mut().Edge().unwrap())
}

fn polygon_wire(points: &[(f64, f64, f64)]) -> cxx::UniquePtr<topo_ds::TopoDS_Wire> {
    let mut make = bb::BRepBuilderAPI_MakeWire_new();
    for i in 0..points.len() {
        make.pin_mut().add_edge(&edge(points[i], points[(i + 1) % points.len()])).unwrap();
    }
    topo_ds::TopoDS_Wire_to_owned(make.pin_mut().Wire().unwrap())
}

fn circle_wire(z: f64, radius: f64) -> cxx::UniquePtr<topo_ds::TopoDS_Wire> {
    let circle =
        gp::gp_Circ_new(&gp::gp_Ax2_new(&pnt(0.0, 0.0, z), &dir(0.0, 0.0, 1.0)), radius).unwrap();
    let mut e = bb::BRepBuilderAPI_MakeEdge_circle(&circle).unwrap();
    let mut w = bb::BRepBuilderAPI_MakeWire_new();
    w.pin_mut().add_edge(e.pin_mut().Edge().unwrap()).unwrap();
    topo_ds::TopoDS_Wire_to_owned(w.pin_mut().Wire().unwrap())
}

fn face_of(wire: &topo_ds::TopoDS_Wire) -> Shape {
    let mut make = bb::BRepBuilderAPI_MakeFace_wire(wire, true).unwrap();
    owned(make.pin_mut().Shape().unwrap())
}

#[test]
fn booleans() {
    let a = make_box(2.0, 2.0, 2.0);
    let b = make_box_at(1.0, 1.0, 1.0, 2.0, 2.0, 2.0);

    let mut fuse = algo::BRepAlgoAPI_Fuse_new(&a, &b).unwrap();
    assert!(fuse.IsDone());
    assert_close(volume(fuse.pin_mut().Shape().unwrap()), 15.0, 1e-6);
    assert!(fuse.pin_mut().SectionEdges().unwrap().Size() > 0);
    fuse.pin_mut().SetGlue(BOPAlgo_GlueEnum::BOPAlgo_GlueOff);
    fuse.pin_mut().Build(&progress()).unwrap();
    assert_close(volume(fuse.pin_mut().Shape().unwrap()), 15.0, 1e-6);

    let mut cut = algo::BRepAlgoAPI_Cut_new(&a, &b).unwrap();
    cut.pin_mut().Build(&progress()).unwrap();
    assert!(cut.IsDone());
    assert_close(volume(cut.pin_mut().Shape().unwrap()), 7.0, 1e-6);
    assert!(cut.pin_mut().SectionEdges().unwrap().Size() > 0);
    let face = first_subshape(&a, TopAbs_ShapeEnum::TopAbs_FACE);
    let _generated = cut.pin_mut().Generated(&face).unwrap().Size();

    let mut common = algo::BRepAlgoAPI_Common_new(&a, &b).unwrap();
    common.pin_mut().Build(&progress()).unwrap();
    assert!(common.IsDone());
    assert_close(volume(common.pin_mut().Shape().unwrap()), 1.0, 1e-6);
    assert!(common.pin_mut().SectionEdges().unwrap().Size() > 0);

    let mut section = algo::BRepAlgoAPI_Section_new(&a, &b).unwrap();
    section.pin_mut().Build(&progress()).unwrap();
    assert!(section.IsDone());
    let edges = unique_count(section.pin_mut().Shape().unwrap(), TopAbs_ShapeEnum::TopAbs_EDGE);
    assert_eq!(edges, 6);
    assert_eq!(section.pin_mut().SectionEdges().unwrap().Size(), 6);
}

#[test]
fn glued_fuse_of_touching_boxes() {
    let a = make_box(1.0, 1.0, 1.0);
    let b = make_box_at(1.0, 0.0, 0.0, 1.0, 1.0, 1.0);
    let mut fuse = algo::BRepAlgoAPI_Fuse_new(&a, &b).unwrap();
    fuse.pin_mut().SetGlue(BOPAlgo_GlueEnum::BOPAlgo_GlueShift);
    fuse.pin_mut().Build(&progress()).unwrap();
    assert!(fuse.IsDone());
    let fused = owned(fuse.pin_mut().Shape().unwrap());
    assert_close(volume(&fused), 2.0, 1e-6);
    assert_eq!(unique_count(&fused, TopAbs_ShapeEnum::TopAbs_FACE), 10);

    let mut unify = shape_upgrade::UnifySameDomain_new(&fused, true, true, true).unwrap();
    unify.pin_mut().allow_internal_edges(false);
    unify.pin_mut().build().unwrap();
    let unified = unify.shape().unwrap();
    assert_eq!(unique_count(unified, TopAbs_ShapeEnum::TopAbs_FACE), 6);
    assert_close(volume(unified), 2.0, 1e-6);

    // Converting to Bézier patches keeps the geometry; planes become Bézier surfaces.
    let bezier = shape_upgrade::ShapeUpgrade_convert_to_bezier(unified).unwrap();
    assert!(!bezier.IsNull());
    assert_close(volume(&bezier), 2.0, 1e-9);
    assert_close(area(&bezier), area(unified), 1e-9);

    let mut full = algo::BRepAlgoAPI_Fuse_new(&a, &b).unwrap();
    full.pin_mut().SetGlue(BOPAlgo_GlueEnum::BOPAlgo_GlueFull);
    full.pin_mut().Build(&progress()).unwrap();
    assert!(full.IsDone());
}

#[test]
fn fillets_and_chamfers() {
    let solid = make_box(10.0, 10.0, 10.0);
    let edges = subshapes(&solid, TopAbs_ShapeEnum::TopAbs_EDGE);

    let mut make = fillet::BRepFilletAPI_MakeFillet_new(&solid).unwrap();
    for e in &edges {
        make.pin_mut().add_edge(1.0, TopoDS::Edge(e).unwrap()).unwrap();
    }
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    let rounded = owned(make.pin_mut().Shape().unwrap());
    // (L-2r)^3 + 6 (L-2r)^2 r + 3 pi r^2 (L-2r) + 4/3 pi r^3 for L = 10, r = 1.
    let expected = 512.0 + 384.0 + 24.0 * PI + 4.0 / 3.0 * PI;
    assert_close(volume(&rounded), expected, 1e-3);
    assert_eq!(unique_count(&rounded, TopAbs_ShapeEnum::TopAbs_FACE), 26);

    // A variable-radius fillet: radius 1 at the start of the edge, 2 at the end.
    let mut radii = t_col_gp::TColgp_Array1OfPnt2d_new(1, 2).unwrap();
    radii.pin_mut().SetValue(1, &gp::new_point_2d(0.0, 1.0)).unwrap();
    radii.pin_mut().SetValue(2, &gp::new_point_2d(10.0, 2.0)).unwrap();
    let mut variable = fillet::BRepFilletAPI_MakeFillet_new(&solid).unwrap();
    variable.pin_mut().variable_add_edge(&radii, TopoDS::Edge(&edges[0]).unwrap()).unwrap();
    variable.pin_mut().Build(&progress()).unwrap();
    assert!(variable.IsDone());
    assert!(volume(variable.pin_mut().Shape().unwrap()) < 1000.0);

    let mut chamfer = fillet::BRepFilletAPI_MakeChamfer_new(&solid).unwrap();
    chamfer.pin_mut().add_edge(1.0, TopoDS::Edge(&edges[0]).unwrap()).unwrap();
    chamfer.pin_mut().Build(&progress()).unwrap();
    assert!(chamfer.IsDone());
    assert_close(volume(chamfer.pin_mut().Shape().unwrap()), 1000.0 - 5.0, 1e-6);

    // A fillet larger than the box fails without crashing.
    let mut too_big = fillet::BRepFilletAPI_MakeFillet_new(&solid).unwrap();
    for e in &edges {
        too_big.pin_mut().add_edge(20.0, TopoDS::Edge(e).unwrap()).unwrap();
    }
    let built = too_big.pin_mut().Build(&progress());
    assert!(built.is_err() || !too_big.IsDone());
    assert!(too_big.pin_mut().Shape().is_err());
}

#[test]
fn planar_fillets_and_chamfers() {
    let face = face_of(&polygon_wire(&[
        (0.0, 0.0, 0.0),
        (4.0, 0.0, 0.0),
        (4.0, 4.0, 0.0),
        (0.0, 4.0, 0.0),
    ]));
    let face = TopoDS::Face(&face).unwrap();
    let vertices = subshapes(topo_ds::cast_face_to_shape(face), TopAbs_ShapeEnum::TopAbs_VERTEX);
    let edges = subshapes(topo_ds::cast_face_to_shape(face), TopAbs_ShapeEnum::TopAbs_EDGE);

    let mut make = fillet::BRepFilletAPI_MakeFillet2d_new(face).unwrap();
    let arc = fillet::BRepFilletAPI_MakeFillet2d_add_fillet(
        make.pin_mut(),
        TopoDS::Vertex(&vertices[0]).unwrap(),
        1.0,
    )
    .unwrap();
    assert_close(length(topo_ds::cast_edge_to_shape(&arc)), PI / 2.0, 1e-6);
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    assert_close(area(make.pin_mut().Shape().unwrap()), 16.0 - 1.0 + PI / 4.0, 1e-6);

    // Chamfer between two adjacent edges, then a distance-angle chamfer.
    let (e0, e1) = (TopoDS::Edge(&edges[0]).unwrap(), TopoDS::Edge(&edges[1]).unwrap());
    let mut shared = topo_ds::TopoDS_Vertex_to_owned(TopoDS::Vertex(&vertices[0]).unwrap());
    assert!(scratchcad_occt_sys::top_exp::TopExp::CommonVertex(e0, e1, shared.pin_mut()).unwrap());
    let mut make = fillet::BRepFilletAPI_MakeFillet2d_new(face).unwrap();
    let bevel =
        fillet::BRepFilletAPI_MakeFillet2d_add_chamfer(make.pin_mut(), e0, e1, 1.0, 1.0).unwrap();
    assert_close(length(topo_ds::cast_edge_to_shape(&bevel)), 2f64.sqrt(), 1e-6);
    make.pin_mut().Build(&progress()).unwrap();
    assert_close(area(make.pin_mut().Shape().unwrap()), 15.5, 1e-6);

    let mut make = fillet::BRepFilletAPI_MakeFillet2d_new(face).unwrap();
    let bevel = fillet::BRepFilletAPI_MakeFillet2d_add_chamfer_angle(
        make.pin_mut(),
        e0,
        &shared,
        1.0,
        PI / 4.0,
    )
    .unwrap();
    assert_close(length(topo_ds::cast_edge_to_shape(&bevel)), 2f64.sqrt(), 1e-6);
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
}

#[test]
fn planar_offsets() {
    let wire = polygon_wire(&[(0.0, 0.0, 0.0), (4.0, 0.0, 0.0), (4.0, 4.0, 0.0), (0.0, 4.0, 0.0)]);
    let face = face_of(&wire);
    let mut make = offset::BRepOffsetAPI_MakeOffset_face_new(
        TopoDS::Face(&face).unwrap(),
        GeomAbs_JoinType::GeomAbs_Arc,
    )
    .unwrap();
    make.pin_mut().Perform(1.0, 0.0).unwrap();
    assert!(make.IsDone());
    // Four straight sides plus four quarter circles.
    assert_close(length(make.pin_mut().Shape().unwrap()), 16.0 + 2.0 * PI, 1e-6);

    let mut make =
        offset::BRepOffsetAPI_MakeOffset_wire_new(&wire, GeomAbs_JoinType::GeomAbs_Intersection)
            .unwrap();
    make.pin_mut().Perform(0.5, 0.0).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    let perimeter = length(make.pin_mut().Shape().unwrap());
    assert!((perimeter - 20.0).abs() < 1e-6 || (perimeter - 12.0).abs() < 1e-6, "{perimeter}");
}

#[test]
fn thick_solid() {
    let solid = make_box(10.0, 10.0, 10.0);
    let top = subshapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE)
        .into_iter()
        .find(|f| {
            let mut props = scratchcad_occt_sys::g_prop::GProps_new();
            scratchcad_occt_sys::b_rep_g_prop::BRepGProp::SurfaceProperties(
                f,
                props.pin_mut(),
                false,
                false,
            )
            .unwrap();
            scratchcad_occt_sys::g_prop::GProp_GProps_CentreOfMass(&props).Z() > 9.0
        })
        .unwrap();
    let mut faces = top_tools::new_list_of_shape();
    faces.pin_mut().Append(&top);
    let mut make = offset::BRepOffsetAPI_MakeThickSolid_new();
    make.pin_mut()
        .MakeThickSolidByJoin(
            &solid,
            &faces,
            -1.0,
            1e-3,
            offset::BRepOffset_Mode::BRepOffset_Skin,
            false,
            false,
            GeomAbs_JoinType::GeomAbs_Arc,
            false,
            &progress(),
        )
        .unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    assert_close(volume(make.pin_mut().Shape().unwrap()), 1000.0 - 8.0 * 8.0 * 9.0, 1e-6);
}

#[test]
fn pipes_and_lofts() {
    let spine = polygon_wire(&[(0.0, 0.0, 0.0), (0.0, 0.0, 10.0)]);
    // polygon_wire closes the loop, so take only the first edge as the spine.
    let spine_edge =
        first_subshape(topo_ds::cast_wire_to_shape(&spine), TopAbs_ShapeEnum::TopAbs_EDGE);
    let mut spine = bb::BRepBuilderAPI_MakeWire_new();
    spine.pin_mut().add_edge(TopoDS::Edge(&spine_edge).unwrap()).unwrap();
    let spine = topo_ds::TopoDS_Wire_to_owned(spine.pin_mut().Wire().unwrap());

    let profile = face_of(&circle_wire(0.0, 1.0));
    let mut pipe = offset::BRepOffsetAPI_MakePipe_new(&spine, &profile).unwrap();
    assert!(pipe.IsDone());
    assert_close(volume(pipe.pin_mut().Shape().unwrap()).abs(), 10.0 * PI, 1e-6);

    let profile_wire = circle_wire(0.0, 1.0);
    let mut shell = offset::BRepOffsetAPI_MakePipeShell_new(&spine).unwrap();
    shell.pin_mut().SetMode(false);
    shell.pin_mut().Add(topo_ds::cast_wire_to_shape(&profile_wire), false, false).unwrap();
    shell.pin_mut().Build(&progress()).unwrap();
    assert!(shell.IsDone());
    assert!(shell.pin_mut().MakeSolid().unwrap());
    assert_close(volume(shell.pin_mut().Shape().unwrap()).abs(), 10.0 * PI, 1e-4);

    // A law scaling the profile from 1x to 2x along the spine.
    let mut points = t_col_gp::TColgp_Array1OfPnt2d_new(1, 2).unwrap();
    points.pin_mut().SetValue(1, &gp::new_point_2d(0.0, 1.0)).unwrap();
    points.pin_mut().SetValue(2, &gp::new_point_2d(10.0, 2.0)).unwrap();
    let mut interpol = law::Law_Interpol_new();
    interpol.pin_mut().Set(&points, false).unwrap();
    let law = law::Law_Function_to_handle(law::Law_Interpol_into_Law_Function(interpol));
    assert!(!law.IsNull());
    let mut scaled = offset::BRepOffsetAPI_MakePipeShell_new(&spine).unwrap();
    scaled
        .pin_mut()
        .SetLaw(topo_ds::cast_wire_to_shape(&profile_wire), &law, false, false)
        .unwrap();
    scaled.pin_mut().Build(&progress()).unwrap();
    assert!(scaled.IsDone());
    assert!(scaled.pin_mut().MakeSolid().unwrap());
    let frustum = PI * 10.0 / 3.0 * (1.0 + 2.0 + 4.0);
    assert_close(volume(scaled.pin_mut().Shape().unwrap()).abs(), frustum, 0.5);

    let mut loft = offset::BRepOffsetAPI_ThruSections_new(true);
    loft.pin_mut().CheckCompatibility(false);
    loft.pin_mut().AddWire(&circle_wire(0.0, 1.0)).unwrap();
    loft.pin_mut().AddWire(&circle_wire(2.0, 2.0)).unwrap();
    loft.pin_mut().Build(&progress()).unwrap();
    assert!(loft.IsDone());
    assert_close(volume(loft.pin_mut().Shape().unwrap()).abs(), 14.0 * PI / 3.0, 1e-4);

    // A ruled loft through three circles is two frustums; a smooth one bulges between them.
    let lofted = |ruled: bool| {
        let mut loft = offset::BRepOffsetAPI_ThruSections_new_ruled(true, ruled);
        for (z, r) in [(0.0, 1.0), (2.0, 2.0), (4.0, 1.0)] {
            loft.pin_mut().AddWire(&circle_wire(z, r)).unwrap();
        }
        loft.pin_mut().Build(&progress()).unwrap();
        assert!(loft.IsDone());
        volume(loft.pin_mut().Shape().unwrap()).abs()
    };
    assert_close(lofted(true), 2.0 * 14.0 * PI / 3.0, 1e-4);
    assert!(lofted(false) > 2.0 * 14.0 * PI / 3.0 + 1.0);
}

#[test]
fn features() {
    let solid = make_box(10.0, 10.0, 10.0);
    let axis = gp::gp_Ax1_new(&pnt(5.0, 5.0, 0.0), &dir(0.0, 0.0, 1.0));
    let mut hole = b_rep_feat::BRepFeat_MakeCylindricalHole_new();
    hole.pin_mut().Init(&solid, &axis).unwrap();
    hole.pin_mut().Perform(1.0).unwrap();
    hole.pin_mut().Build().unwrap();
    assert_close(volume(hole.Shape().unwrap()), 1000.0 - 10.0 * PI, 1e-4);

    // A drafted boss on the top face.
    let top = subshapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE)
        .into_iter()
        .find(|f| {
            area(f) > 0.0 && {
                let mut props = scratchcad_occt_sys::g_prop::GProps_new();
                scratchcad_occt_sys::b_rep_g_prop::BRepGProp::SurfaceProperties(
                    f,
                    props.pin_mut(),
                    false,
                    false,
                )
                .unwrap();
                scratchcad_occt_sys::g_prop::GProp_GProps_CentreOfMass(&props).Z() > 9.0
            }
        })
        .unwrap();
    let profile = face_of(&polygon_wire(&[
        (2.0, 2.0, 10.0),
        (4.0, 2.0, 10.0),
        (4.0, 4.0, 10.0),
        (2.0, 4.0, 10.0),
    ]));
    let mut boss = b_rep_feat::BRepFeat_MakeDPrism_new(
        &solid,
        TopoDS::Face(&profile).unwrap(),
        TopoDS::Face(&top).unwrap(),
        0.0,
        1,
        true,
    )
    .unwrap();
    boss.pin_mut().perform_with_height(5.0).unwrap();
    assert_close(volume(boss.pin_mut().Shape().unwrap()), 1020.0, 1e-4);

    // An additive prism from the top face up to a separate "until" face at z = 15 (the
    // pattern the original `opencascade` crate's keycap example used).
    let ceiling = make_box_at(0.0, 0.0, 15.0, 10.0, 10.0, 1.0);
    let until = subshapes(&ceiling, TopAbs_ShapeEnum::TopAbs_FACE)
        .into_iter()
        .find(|f| {
            let mut props = scratchcad_occt_sys::g_prop::GProps_new();
            scratchcad_occt_sys::b_rep_g_prop::BRepGProp::SurfaceProperties(
                f,
                props.pin_mut(),
                false,
                false,
            )
            .unwrap();
            (scratchcad_occt_sys::g_prop::GProp_GProps_CentreOfMass(&props).Z() - 15.0).abs() < 1e-9
        })
        .unwrap();
    let mut column = b_rep_feat::BRepFeat_MakeDPrism_new(
        &solid,
        TopoDS::Face(&profile).unwrap(),
        &topo_ds::TopoDS_Face_new(),
        0.0,
        1,
        false,
    )
    .unwrap();
    column.pin_mut().perform_until_face(&until).unwrap();
    assert_close(volume(column.pin_mut().Shape().unwrap()), 1000.0 + 20.0, 1e-4);
}

#[test]
fn connect_loose_edges_into_wires() {
    let mut edges = top_tools::new_Handle_TopTools_HSequenceOfShape();
    // Deliberately out of order.
    for (a, b) in [
        ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0)),
        ((0.0, 0.0, 0.0), (1.0, 0.0, 0.0)),
        ((0.0, 1.0, 0.0), (0.0, 0.0, 0.0)),
    ] {
        top_tools::TopTools_HSequenceOfShape_append(
            edges.pin_mut(),
            topo_ds::cast_edge_to_shape(&edge(a, b)),
        )
        .unwrap();
    }
    let mut wires = top_tools::new_Handle_TopTools_HSequenceOfShape();
    shape_analysis::ShapeAnalysis_FreeBounds::ConnectEdgesToWires(
        edges.pin_mut(),
        1e-6,
        false,
        wires.pin_mut(),
    )
    .unwrap();
    assert_eq!(top_tools::TopTools_HSequenceOfShape_length(&wires).unwrap(), 1);
    let wire = top_tools::TopTools_HSequenceOfShape_value(&wires, 1).unwrap();
    assert_eq!(unique_count(wire, TopAbs_ShapeEnum::TopAbs_EDGE), 3);
    assert!(scratchcad_occt_sys::b_rep::BRep_Tool::IsClosed(wire));
}

#[test]
fn prism_of_a_cut_profile() {
    // Combining several algorithms: a face with a hole, extruded.
    let outer = face_of(&polygon_wire(&[
        (0.0, 0.0, 0.0),
        (4.0, 0.0, 0.0),
        (4.0, 4.0, 0.0),
        (0.0, 4.0, 0.0),
    ]));
    let inner = face_of(&polygon_wire(&[
        (1.0, 1.0, 0.0),
        (3.0, 1.0, 0.0),
        (3.0, 3.0, 0.0),
        (1.0, 3.0, 0.0),
    ]));
    let mut cut = algo::BRepAlgoAPI_Cut_new(&outer, &inner).unwrap();
    let profile = owned(cut.pin_mut().Shape().unwrap());
    assert_close(area(&profile), 12.0, 1e-6);
    let mut prism =
        prim::BRepPrimAPI_MakePrism_new(&profile, &gp::new_vec(0.0, 0.0, 2.0), true, true).unwrap();
    assert_close(volume(prism.pin_mut().Shape().unwrap()), 24.0, 1e-6);
}
