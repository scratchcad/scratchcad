mod common;

use common::{assert_close, dir, pnt, progress, unique_count, volume};
use scratchcad_occt_sys::{
    b_rep_builder_api as bb, b_rep_prim_api as prim, gp, top_abs::TopAbs_ShapeEnum,
};
use std::f64::consts::{PI, TAU};

fn z_axis() -> cxx::UniquePtr<gp::gp_Ax2> {
    gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0))
}

#[test]
fn box_volume_and_topology() {
    let mut make = prim::BRepPrimAPI_MakeBox_new(&pnt(1.0, 1.0, 1.0), 1.0, 2.0, 3.0).unwrap();
    make.pin_mut().Build(&progress()).unwrap();
    assert!(make.IsDone());
    let shape = make.pin_mut().Shape().unwrap();
    assert_close(volume(shape), 6.0, 1e-9);
    assert_eq!(unique_count(shape, TopAbs_ShapeEnum::TopAbs_FACE), 6);
}

#[test]
fn cylinder_sphere_cone_torus_volumes() {
    let mut cylinder = prim::BRepPrimAPI_MakeCylinder_new(&z_axis(), 1.0, 2.0).unwrap();
    cylinder.pin_mut().Build(&progress()).unwrap();
    assert!(cylinder.IsDone());
    assert_close(volume(cylinder.pin_mut().Shape().unwrap()), 2.0 * PI, 1e-6);

    let mut sphere = prim::BRepPrimAPI_MakeSphere_new(&z_axis(), 2.0, TAU).unwrap();
    sphere.pin_mut().Build(&progress()).unwrap();
    assert!(sphere.IsDone());
    assert_close(volume(sphere.pin_mut().Shape().unwrap()), 32.0 * PI / 3.0, 1e-6);
    let mut half = prim::BRepPrimAPI_MakeSphere_new(&z_axis(), 2.0, PI).unwrap();
    assert_close(volume(half.pin_mut().Shape().unwrap()), 16.0 * PI / 3.0, 1e-6);

    let mut cone = prim::BRepPrimAPI_MakeCone_new(&z_axis(), 1.0, 0.0, 3.0, TAU).unwrap();
    cone.pin_mut().Build(&progress()).unwrap();
    assert!(cone.IsDone());
    assert_close(volume(cone.pin_mut().Shape().unwrap()), PI, 1e-6);

    let mut torus = prim::BRepPrimAPI_MakeTorus_new(&z_axis(), 3.0, 1.0, 0.0, TAU, TAU).unwrap();
    torus.pin_mut().Build(&progress()).unwrap();
    assert!(torus.IsDone());
    assert_close(volume(torus.pin_mut().Shape().unwrap()), 6.0 * PI * PI, 1e-6);
}

fn square_face(x0: f64, size: f64) -> cxx::UniquePtr<scratchcad_occt_sys::topo_ds::TopoDS_Shape> {
    let corners = [(x0, 0.0), (x0 + size, 0.0), (x0 + size, size), (x0, size)];
    let mut wire = bb::BRepBuilderAPI_MakeWire_new();
    for i in 0..4 {
        let (a, b) = (corners[i], corners[(i + 1) % 4]);
        let mut edge =
            bb::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&pnt(a.0, 0.0, a.1), &pnt(b.0, 0.0, b.1))
                .unwrap();
        wire.pin_mut().add_edge(edge.pin_mut().Edge().unwrap()).unwrap();
    }
    let mut face = bb::BRepBuilderAPI_MakeFace_wire(wire.pin_mut().Wire().unwrap(), true).unwrap();
    scratchcad_occt_sys::topo_ds::TopoDS_Shape_to_owned(face.pin_mut().Shape().unwrap())
}

#[test]
fn prism_and_revolution_sweep_faces() {
    // A 2x2 square in the XZ plane, extruded 3 along Y.
    let face = square_face(0.0, 2.0);
    let mut prism =
        prim::BRepPrimAPI_MakePrism_new(&face, &gp::new_vec(0.0, 3.0, 0.0), true, true).unwrap();
    prism.pin_mut().Build(&progress()).unwrap();
    assert!(prism.IsDone());
    assert_close(volume(prism.pin_mut().Shape().unwrap()).abs(), 12.0, 1e-6);

    // The same square moved to x in [2, 4], revolved fully around Z: a ring.
    let face = square_face(2.0, 2.0);
    let axis = gp::gp_Ax1_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0));
    let mut revol = prim::BRepPrimAPI_MakeRevol_new(&face, &axis, TAU, true).unwrap();
    revol.pin_mut().Build(&progress()).unwrap();
    assert!(revol.IsDone());
    let expected = PI * (16.0 - 4.0) * 2.0;
    assert_close(volume(revol.pin_mut().Shape().unwrap()).abs(), expected, 1e-6);
}
