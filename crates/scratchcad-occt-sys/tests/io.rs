//! STEP, IGES, STL and BREP files. OCCT's data exchange keeps global state, so these tests
//! serialize themselves.

mod common;

use common::{assert_close, make_box, temp_path, volume};
use scratchcad_occt_sys::{
    b_rep_mesh, b_rep_tools, bin_tools, if_select::IFSelect_ReturnStatus, iges_control,
    step_control, stl_api,
};
use std::sync::Mutex;

static LOCK: Mutex<()> = Mutex::new(());

fn path_string(name: &str) -> String {
    temp_path(name).to_string_lossy().into_owned()
}

#[test]
fn step_round_trip() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let path = path_string("box.step");
    let solid = make_box(1.0, 2.0, 3.0);

    let mut writer = step_control::STEPControl_Writer_new();
    assert_eq!(
        step_control::transfer_shape(writer.pin_mut(), &solid).unwrap(),
        IFSelect_ReturnStatus::IFSelect_RetDone
    );
    assert_eq!(
        step_control::write_step(writer.pin_mut(), path.clone()).unwrap(),
        IFSelect_ReturnStatus::IFSelect_RetDone
    );

    let mut reader = step_control::STEPControl_Reader_new();
    assert_eq!(
        step_control::read_step(reader.pin_mut(), path).unwrap(),
        IFSelect_ReturnStatus::IFSelect_RetDone
    );
    assert!(reader.pin_mut().TransferRoots(&common::progress()).unwrap() >= 1);
    let shape = step_control::one_shape_step(&reader).unwrap();
    assert_close(volume(&shape), 6.0, 1e-6);
}

#[test]
fn reading_a_missing_step_file_reports_an_error_status() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let mut reader = step_control::STEPControl_Reader_new();
    let status = step_control::read_step(reader.pin_mut(), path_string("missing.step")).unwrap();
    assert_ne!(status, IFSelect_ReturnStatus::IFSelect_RetDone);
}

#[test]
fn iges_round_trip() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let path = path_string("box.igs");
    let solid = make_box(2.0, 2.0, 2.0);

    let mut writer = iges_control::IGESControl_Writer_new();
    assert!(writer.pin_mut().AddShape(&solid, &common::progress()).unwrap());
    writer.pin_mut().ComputeModel().unwrap();
    assert!(iges_control::write_iges(writer.pin_mut(), path.clone()).unwrap());

    let mut reader = iges_control::IGESControl_Reader_new();
    assert_eq!(
        iges_control::read_iges(reader.pin_mut(), path).unwrap(),
        IFSelect_ReturnStatus::IFSelect_RetDone
    );
    assert!(reader.pin_mut().TransferRoots(&common::progress()).unwrap() >= 1);
    let shape = iges_control::one_shape_iges(&reader).unwrap();
    assert!(!shape.IsNull());

    let mut missing = iges_control::IGESControl_Reader_new();
    let status = iges_control::read_iges(missing.pin_mut(), path_string("missing.igs")).unwrap();
    assert_ne!(status, IFSelect_ReturnStatus::IFSelect_RetDone);
}

#[test]
fn brep_text_and_binary_round_trips() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let solid = make_box(1.0, 1.0, 4.0);

    let text = path_string("box.brep");
    assert!(b_rep_tools::write(&solid, text.clone()).unwrap());
    let read = b_rep_tools::read(text).unwrap();
    assert!(!read.is_null());
    assert_close(volume(&read), 4.0, 1e-9);
    assert!(b_rep_tools::read(path_string("missing.brep")).unwrap().is_null());

    let binary = path_string("box.bin.brep");
    assert!(bin_tools::write(&solid, binary.clone()).unwrap());
    let read = bin_tools::read(binary).unwrap();
    assert!(!read.is_null());
    assert_close(volume(&read), 4.0, 1e-9);
    assert!(bin_tools::read(path_string("missing.bin.brep")).unwrap().is_null());

    // Writing into a directory that does not exist fails.
    let bad = temp_path("no-such-dir").join("x.brep").to_string_lossy().into_owned();
    assert!(!b_rep_tools::write(&solid, bad.clone()).unwrap());
    assert!(!bin_tools::write(&solid, bad).unwrap());
}

#[test]
fn stl_export() {
    let _guard = LOCK.lock().unwrap_or_else(|e| e.into_inner());
    let solid = make_box(1.0, 1.0, 1.0);
    let mesh = b_rep_mesh::IncrementalMesh_new(&solid, 0.1).unwrap();
    assert!(mesh.IsDone());
    let path = path_string("box.stl");
    let mut writer = stl_api::StlAPI_Writer_new();
    assert!(stl_api::write_stl(writer.pin_mut(), &solid, path.clone()).unwrap());
    // StlAPI_Writer writes ASCII STL by default; a meshed cube has 12 triangles.
    let contents = std::fs::read_to_string(&path).unwrap();
    assert!(contents.starts_with("solid"));
    assert_eq!(contents.matches("facet normal").count(), 12);
}
