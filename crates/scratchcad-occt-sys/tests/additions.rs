//! In-memory data exchange, non-destructive booleans, deep copies, point classification,
//! meshing parameters, cancellation and message redirection.

mod common;

use common::{assert_close, make_box, make_box_at, pnt, progress, unique_count, volume};
use scratchcad_occt_sys::{
    b_rep_algo_api, b_rep_builder_api, b_rep_class3d,
    b_rep_g_prop::BRepGProp,
    b_rep_mesh, b_rep_tools, g_prop,
    if_select::IFSelect_ReturnStatus,
    iges_control,
    message::{self, CancelFlag, Message_Gravity},
    step_control,
    top_abs::{TopAbs_ShapeEnum, TopAbs_State},
};
use std::sync::{Arc, Mutex};

/// STEP and IGES keep global state; the message test swaps the global printers.
static LOCK: Mutex<()> = Mutex::new(());

#[test]
fn step_round_trip_in_memory() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let solid = make_box(1.0, 2.0, 3.0);
    let mut writer = step_control::STEPControl_Writer_new();
    let status =
        step_control::transfer_shape_with_progress(writer.pin_mut(), &solid, &progress()).unwrap();
    assert_eq!(status, IFSelect_ReturnStatus::IFSelect_RetDone);
    let bytes = step_control::write_step_bytes(writer.pin_mut()).unwrap();
    let bytes = bytes.as_ref().unwrap().as_bytes();
    assert!(bytes.starts_with(b"ISO-10303-21;"));

    let mut reader = step_control::STEPControl_Reader_new();
    let status = step_control::read_step_bytes(reader.pin_mut(), bytes).unwrap();
    assert_eq!(status, IFSelect_ReturnStatus::IFSelect_RetDone);
    assert!(reader.pin_mut().TransferRoots(&progress()).unwrap() >= 1);
    let shape = step_control::one_shape_step(&reader).unwrap();
    assert_close(volume(&shape), 6.0, 1e-6);

    let mut reader = step_control::STEPControl_Reader_new();
    let status = step_control::read_step_bytes(reader.pin_mut(), b"not a step file").unwrap();
    assert_ne!(status, IFSelect_ReturnStatus::IFSelect_RetDone);
}

#[test]
fn iges_to_memory() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let solid = make_box(2.0, 2.0, 2.0);
    let mut writer = iges_control::IGESControl_Writer_new();
    assert!(writer.pin_mut().AddShape(&solid, &progress()).unwrap());
    writer.pin_mut().ComputeModel().unwrap();
    let bytes = iges_control::write_iges_bytes(writer.pin_mut()).unwrap();
    let text = String::from_utf8_lossy(bytes.as_ref().unwrap().as_bytes()).into_owned();
    // IGES files are 80-column records; the last one is the terminate section ('T').
    assert!(text.lines().all(|line| line.len() == 80), "{text}");
    assert_eq!(text.lines().last().unwrap().as_bytes()[72], b'T');
}

#[test]
fn brep_round_trip_in_memory() {
    let solid = make_box(1.0, 1.0, 2.0);
    let bytes = b_rep_tools::write_brep_bytes(&solid, &progress()).unwrap();
    let bytes = bytes.as_ref().unwrap().as_bytes().to_vec();
    assert!(bytes.starts_with(b"DBRep_DrawableShape"));
    let shape = b_rep_tools::read_brep_bytes(&bytes, &progress()).unwrap();
    assert_close(volume(&shape), 2.0, 1e-12);
    assert!(b_rep_tools::read_brep_bytes(b"junk", &progress()).unwrap().is_null());
}

#[test]
fn non_destructive_booleans() {
    let a = make_box(2.0, 2.0, 2.0);
    let b = make_box_at(1.0, 1.0, 1.0, 2.0, 2.0, 2.0);
    let fuse = b_rep_algo_api::BRepAlgoAPI_fuse(&a, &b, &progress()).unwrap();
    assert_close(volume(&fuse), 15.0, 1e-9);
    let cut = b_rep_algo_api::BRepAlgoAPI_cut(&a, &b, &progress()).unwrap();
    assert_close(volume(&cut), 7.0, 1e-9);
    let common = b_rep_algo_api::BRepAlgoAPI_common(&a, &b, &progress()).unwrap();
    assert_close(volume(&common), 1.0, 1e-9);
    let section = b_rep_algo_api::BRepAlgoAPI_section(&a, &b, &progress()).unwrap();
    assert!(unique_count(&section, TopAbs_ShapeEnum::TopAbs_EDGE) > 0);
    // The arguments keep their original volumes.
    assert_close(volume(&a), 8.0, 1e-9);
    assert_close(volume(&b), 8.0, 1e-9);
}

#[test]
fn deep_copies_share_nothing() {
    let solid = make_box(1.0, 2.0, 3.0);
    let copy = b_rep_builder_api::BRepBuilderAPI_copy_shape(&solid).unwrap();
    assert_close(volume(&copy), 6.0, 1e-12);
    assert!(!copy.IsSame(&solid));
    assert_eq!(unique_count(&copy, TopAbs_ShapeEnum::TopAbs_FACE), 6);
}

#[test]
fn point_classification() {
    let solid = make_box(2.0, 2.0, 2.0);
    let classify = |x, y, z| b_rep_class3d::classify_point(&solid, &pnt(x, y, z), 1e-7).unwrap();
    assert_eq!(classify(1.0, 1.0, 1.0), TopAbs_State::TopAbs_IN);
    assert_eq!(classify(3.0, 1.0, 1.0), TopAbs_State::TopAbs_OUT);
    assert_eq!(classify(2.0, 1.0, 1.0), TopAbs_State::TopAbs_ON);
}

fn surface_area(shape: &scratchcad_occt_sys::topo_ds::TopoDS_Shape) -> f64 {
    let mut props = g_prop::GProps_new();
    // Measured from the triangulation, so finer meshes come closer to the true area.
    BRepGProp::SurfaceProperties(shape, props.pin_mut(), false, true).unwrap();
    props.Mass()
}

#[test]
fn mesh_parameters() {
    let solid = common::make_cylinder(1.0, 1.0);
    let coarse = b_rep_builder_api::BRepBuilderAPI_copy_shape(&solid).unwrap();
    let mesh =
        b_rep_mesh::IncrementalMesh_with_parameters(&coarse, 1.0, 1.0, false, false, &progress())
            .unwrap();
    assert!(mesh.IsDone());
    let fine = b_rep_builder_api::BRepBuilderAPI_copy_shape(&solid).unwrap();
    let mesh =
        b_rep_mesh::IncrementalMesh_with_parameters(&fine, 1.0, 0.05, true, true, &progress())
            .unwrap();
    assert!(mesh.IsDone());
    let exact = 4.0 * std::f64::consts::PI;
    assert!((surface_area(&fine) - exact).abs() < (surface_area(&coarse) - exact).abs());
}

#[test]
fn cancellable_progress_stops_algorithms() {
    let a = make_box(2.0, 2.0, 2.0);
    let b = make_box_at(1.0, 1.0, 1.0, 2.0, 2.0, 2.0);
    let flag = CancelFlag::new();
    // SAFETY: `flag` outlives `running`.
    let running = unsafe { message::Message_CancellableProgress_new(&flag) };
    let range = message::Message_CancellableProgress_range(&running);
    assert!(!b_rep_algo_api::BRepAlgoAPI_fuse(&a, &b, range).unwrap().is_null());

    flag.cancel();
    assert!(flag.is_cancelled());
    // SAFETY: `flag` outlives `stopped`.
    let stopped = unsafe { message::Message_CancellableProgress_new(&flag) };
    let range = message::Message_CancellableProgress_range(&stopped);
    assert!(b_rep_algo_api::BRepAlgoAPI_fuse(&a, &b, range).unwrap().is_null());
}

#[test]
fn messages_reach_the_rust_handler() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let seen = Arc::new(Mutex::new(Vec::new()));
    let sink = seen.clone();
    message::set_message_handler(Some(Arc::new(move |gravity, text: &str| {
        sink.lock().unwrap().push((gravity, text.to_owned()));
    })));
    message::Message_use_rust_printer(Message_Gravity::Message_Info);
    assert_eq!(message::Message_default_printer_count(), 1);

    // Writing STEP reports transfer statistics at the info level.
    let mut writer = step_control::STEPControl_Writer_new();
    step_control::transfer_shape(writer.pin_mut(), &make_box(1.0, 1.0, 1.0)).unwrap();
    step_control::write_step_bytes(writer.pin_mut()).unwrap();
    assert!(!seen.lock().unwrap().is_empty());

    // A handler that panics loses its message instead of unwinding into C++.
    message::set_message_handler(Some(Arc::new(|_, _: &str| panic!("handler failed"))));
    let mut writer = step_control::STEPControl_Writer_new();
    step_control::transfer_shape(writer.pin_mut(), &make_box(1.0, 1.0, 1.0)).unwrap();

    message::set_message_handler(None);
    let mut writer = step_control::STEPControl_Writer_new();
    step_control::transfer_shape(writer.pin_mut(), &make_box(1.0, 1.0, 1.0)).unwrap();

    message::Message_use_stream_printer(true, Message_Gravity::Message_Fail);
    assert_eq!(message::Message_default_printer_count(), 1);
    message::Message_use_stream_printer(false, Message_Gravity::Message_Fail);
    assert_eq!(message::Message_default_printer_count(), 1);
}
