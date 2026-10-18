//! Helpers shared by the integration tests. Everything here calls the real bindings.
#![allow(dead_code)]

use cxx::UniquePtr;
use scratchcad_occt_sys::{
    b_rep_g_prop::BRepGProp,
    b_rep_prim_api, g_prop, gp,
    message::Message_ProgressRange_new,
    top_abs::TopAbs_ShapeEnum,
    top_exp::{TopExp, TopExp_Explorer_new},
    top_tools::new_indexed_map_of_shape,
    topo_ds::{TopoDS_Shape, TopoDS_Shape_to_owned},
};

pub const EPS: f64 = 1e-6;

#[track_caller]
pub fn assert_close(actual: f64, expected: f64, tolerance: f64) {
    assert!(
        (actual - expected).abs() <= tolerance,
        "expected {expected} ± {tolerance}, got {actual}"
    );
}

pub fn pnt(x: f64, y: f64, z: f64) -> UniquePtr<gp::gp_Pnt> {
    gp::new_point(x, y, z)
}

pub fn dir(x: f64, y: f64, z: f64) -> UniquePtr<gp::gp_Dir> {
    gp::gp_Dir_new(x, y, z).unwrap()
}

pub fn progress() -> UniquePtr<scratchcad_occt_sys::message::Message_ProgressRange> {
    Message_ProgressRange_new()
}

/// An axis-aligned box with one corner at `(x, y, z)`.
pub fn make_box_at(x: f64, y: f64, z: f64, dx: f64, dy: f64, dz: f64) -> UniquePtr<TopoDS_Shape> {
    let mut make = b_rep_prim_api::BRepPrimAPI_MakeBox_new(&pnt(x, y, z), dx, dy, dz).unwrap();
    TopoDS_Shape_to_owned(make.pin_mut().Shape().unwrap())
}

pub fn make_box(dx: f64, dy: f64, dz: f64) -> UniquePtr<TopoDS_Shape> {
    make_box_at(0.0, 0.0, 0.0, dx, dy, dz)
}

/// A cylinder standing on the XY plane around the Z axis.
pub fn make_cylinder(radius: f64, height: f64) -> UniquePtr<TopoDS_Shape> {
    let axis = gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &dir(0.0, 0.0, 1.0));
    let mut make = b_rep_prim_api::BRepPrimAPI_MakeCylinder_new(&axis, radius, height).unwrap();
    TopoDS_Shape_to_owned(make.pin_mut().Shape().unwrap())
}

/// The number of times an explorer visits sub-shapes of `kind` (shared ones count repeatedly).
pub fn explore_count(shape: &TopoDS_Shape, kind: TopAbs_ShapeEnum) -> usize {
    let mut explorer = TopExp_Explorer_new(shape, kind);
    let mut count = 0;
    while explorer.More() {
        count += 1;
        explorer.pin_mut().Next();
    }
    count
}

/// The number of distinct sub-shapes of `kind`.
pub fn unique_count(shape: &TopoDS_Shape, kind: TopAbs_ShapeEnum) -> usize {
    let mut map = new_indexed_map_of_shape();
    TopExp::MapShapes(shape, kind, map.pin_mut()).unwrap();
    map.Extent() as usize
}

/// The first sub-shape of `kind`.
pub fn first_subshape(shape: &TopoDS_Shape, kind: TopAbs_ShapeEnum) -> UniquePtr<TopoDS_Shape> {
    let explorer = TopExp_Explorer_new(shape, kind);
    assert!(explorer.More(), "no sub-shape of type {kind:?}");
    TopoDS_Shape_to_owned(explorer.Current().unwrap())
}

/// All sub-shapes of `kind` in exploration order (shared ones only once).
pub fn subshapes(shape: &TopoDS_Shape, kind: TopAbs_ShapeEnum) -> Vec<UniquePtr<TopoDS_Shape>> {
    let mut map = new_indexed_map_of_shape();
    TopExp::MapShapes(shape, kind, map.pin_mut()).unwrap();
    (1..=map.Extent()).map(|i| TopoDS_Shape_to_owned(map.FindKey(i).unwrap())).collect()
}

pub fn volume(shape: &TopoDS_Shape) -> f64 {
    let mut props = g_prop::GProps_new();
    BRepGProp::VolumeProperties(shape, props.pin_mut(), false, false, false).unwrap();
    props.Mass()
}

pub fn area(shape: &TopoDS_Shape) -> f64 {
    let mut props = g_prop::GProps_new();
    BRepGProp::SurfaceProperties(shape, props.pin_mut(), false, false).unwrap();
    props.Mass()
}

pub fn length(shape: &TopoDS_Shape) -> f64 {
    let mut props = g_prop::GProps_new();
    BRepGProp::LinearProperties(shape, props.pin_mut(), false, false).unwrap();
    props.Mass()
}

/// A unique scratch file path inside the target directory.
pub fn temp_path(name: &str) -> std::path::PathBuf {
    let dir =
        std::env::temp_dir().join(format!("scratchcad-occt-sys-tests-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    dir.join(name)
}
