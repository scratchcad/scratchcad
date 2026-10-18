pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_extrema.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type gp_Pnt = crate::gp::gp_Pnt;

        type BRepExtrema_DistShapeShape;

        /// Computes the minimum distance between two shapes.
        #[cxx_name = "construct_unique"]
        pub fn BRepExtrema_DistShapeShape_new(
            shape_1: &TopoDS_Shape,
            shape_2: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepExtrema_DistShapeShape>>;
        pub fn IsDone(self: &BRepExtrema_DistShapeShape) -> bool;
        /// Fails with `StdFail_NotDone` when the computation did not succeed.
        pub fn Value(self: &BRepExtrema_DistShapeShape) -> Result<f64>;
        pub fn NbSolution(self: &BRepExtrema_DistShapeShape) -> i32;
        /// 1-based. Fails with `Standard_OutOfRange` for an invalid index.
        pub fn BRepExtrema_DistShapeShape_point_on_shape_1(
            dist: &BRepExtrema_DistShapeShape,
            index: i32,
        ) -> Result<UniquePtr<gp_Pnt>>;
        /// 1-based. Fails with `Standard_OutOfRange` for an invalid index.
        pub fn BRepExtrema_DistShapeShape_point_on_shape_2(
            dist: &BRepExtrema_DistShapeShape,
            index: i32,
        ) -> Result<UniquePtr<gp_Pnt>>;
    }
}
