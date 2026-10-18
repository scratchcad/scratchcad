//! C++ exceptions thrown by OpenCASCADE must surface as `Err(cxx::Exception)` instead of
//! aborting the process.

mod common;

use common::{make_box, pnt};
use scratchcad_occt_sys::{
    b_rep_builder_api, b_rep_extrema, gc, geom, gp, standard, t_col_gp, top_tools,
    topo_ds::{TopoDS, TopoDS_Shape_new},
};

#[track_caller]
fn assert_exception<T>(result: Result<T, cxx::Exception>, expected_prefix: &str) -> String {
    match result {
        Ok(_) => panic!("expected an exception starting with {expected_prefix}"),
        Err(e) => {
            let message = e.what().to_owned();
            assert!(message.starts_with(expected_prefix), "unexpected message: {message}");
            message
        },
    }
}

#[test]
fn construction_error_carries_type_and_message() {
    let message = assert_exception(gp::gp_Dir_new(0.0, 0.0, 0.0), "Standard_ConstructionError");
    assert!(message.contains(": "), "message should include OCCT's description: {message}");
    assert_exception(gp::gp_Dir2d_new(0.0, 0.0), "Standard_ConstructionError");
}

#[test]
fn type_mismatch_on_bad_downcast() {
    let solid = make_box(1.0, 1.0, 1.0);
    assert!(TopoDS::Solid(&solid).is_ok());
    assert_exception(TopoDS::Face(&solid), "Standard_TypeMismatch");
    assert_exception(TopoDS::Edge(&solid), "Standard_TypeMismatch");
    assert_exception(TopoDS::Vertex(&solid), "Standard_TypeMismatch");
    assert_exception(TopoDS::Wire(&solid), "Standard_TypeMismatch");
    assert_exception(TopoDS::Shell(&solid), "Standard_TypeMismatch");
    assert_exception(TopoDS::Compound(&solid), "Standard_TypeMismatch");
}

#[test]
fn not_done_when_reading_a_failed_builder() {
    let p = pnt(1.0, 2.0, 3.0);
    let mut make = b_rep_builder_api::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&p, &p).unwrap();
    assert!(!make.IsDone());
    assert_exception(make.pin_mut().Edge(), "StdFail_NotDone");
}

#[test]
fn not_done_for_impossible_arc() {
    let make = gc::GC_MakeArcOfCircle_point_point_point(
        &pnt(0.0, 0.0, 0.0),
        &pnt(1.0, 0.0, 0.0),
        &pnt(2.0, 0.0, 0.0),
    )
    .unwrap();
    assert_exception(gc::GC_MakeArcOfCircle_Value(&make), "StdFail_NotDone");

    // These checks are explicit in the bindings because OCCT's release build compiles its own
    // `*_Raise_if` checks out.
    let p = pnt(1.0, 1.0, 1.0);
    assert_exception(gc::GC_MakeSegment_point_point(&p, &p), "Standard_ConstructionError");
    let q = gp::new_point_2d(1.0, 1.0);
    assert_exception(gc::GCE2d_MakeSegment_point_point(&q, &q), "StdFail_NotDone");
}

#[test]
fn reading_a_line_as_a_circle_fails() {
    let solid = make_box(1.0, 1.0, 1.0);
    let edge =
        common::first_subshape(&solid, scratchcad_occt_sys::top_abs::TopAbs_ShapeEnum::TopAbs_EDGE);
    let curve =
        scratchcad_occt_sys::b_rep_adaptor::BRepAdaptor_Curve_new(TopoDS::Edge(&edge).unwrap())
            .unwrap();
    assert_exception(
        scratchcad_occt_sys::b_rep_adaptor::BRepAdaptor_Curve_circle(&curve),
        "Standard_NoSuchObject",
    );
}

#[test]
fn null_handles_are_rejected_instead_of_dereferenced() {
    // A cylinder is not a plane, so the down-cast yields a null handle.
    let axis =
        gp::gp_Ax3_from_gp_Ax2(&gp::gp_Ax2_new(&pnt(0.0, 0.0, 0.0), &common::dir(0.0, 0.0, 1.0)));
    let cylinder = geom::Geom_CylindricalSurface_new(&axis, 1.0).unwrap();
    let surface = geom::cylinder_to_surface(&cylinder);
    let plane = geom::new_HandleGeomPlane_from_HandleGeomSurface(&surface);
    assert!(plane.IsNull());
    let message = assert_exception(geom::handle_geom_plane_location(&plane), "Standard_NullObject");
    assert_eq!(message, "Standard_NullObject: null handle dereference");

    let null_sequence = top_tools::new_Handle_TopTools_HSequenceOfShape();
    assert!(!null_sequence.IsNull());
    assert!(top_tools::HandleTopTools_HSequenceOfShape_Get(&null_sequence).is_ok());

    // Non-null handles still work through the same helpers.
    let surface_type = geom::DynamicType(&surface).unwrap();
    assert_eq!(standard::type_name(surface_type).unwrap(), "Geom_CylindricalSurface");
}

#[test]
fn out_of_range_indices() {
    let array = t_col_gp::TColgp_HArray1OfPnt_new(1, 3).unwrap();
    assert!(t_col_gp::TColgp_HArray1OfPnt_Value(&array, 1).is_ok());
    assert_exception(t_col_gp::TColgp_HArray1OfPnt_Value(&array, 0), "Standard_OutOfRange");
    assert_exception(t_col_gp::TColgp_HArray1OfPnt_Value(&array, 4), "Standard_OutOfRange");

    let a = make_box(1.0, 1.0, 1.0);
    let b = common::make_box_at(3.0, 0.0, 0.0, 1.0, 1.0, 1.0);
    let dist = b_rep_extrema::BRepExtrema_DistShapeShape_new(&a, &b).unwrap();
    assert_exception(
        b_rep_extrema::BRepExtrema_DistShapeShape_point_on_shape_1(&dist, 0),
        "Standard_OutOfRange",
    );
    assert_exception(
        b_rep_extrema::BRepExtrema_DistShapeShape_point_on_shape_2(&dist, 99),
        "Standard_OutOfRange",
    );
}

#[test]
fn null_shape_operations_fail_cleanly() {
    let null = TopoDS_Shape_new();
    assert!(null.IsNull());
    // Down-casting a null shape is allowed by OCCT and yields a null shape of the target type.
    assert!(TopoDS::Face(&null).is_ok());
}

#[test]
fn many_exceptions_do_not_destabilize_the_process() {
    for _ in 0..2000 {
        assert!(gp::gp_Dir_new(0.0, 0.0, 0.0).is_err());
    }
    assert!(gp::gp_Dir_new(0.0, 0.0, 1.0).is_ok());
}

#[test]
fn exceptions_are_thread_safe() {
    let handles: Vec<_> = (0..4)
        .map(|_| {
            std::thread::spawn(|| {
                for _ in 0..200 {
                    let err = gp::gp_Dir_new(0.0, 0.0, 0.0).err().unwrap();
                    assert!(err.what().starts_with("Standard_ConstructionError"));
                }
            })
        })
        .collect();
    for handle in handles {
        handle.join().unwrap();
    }
}
