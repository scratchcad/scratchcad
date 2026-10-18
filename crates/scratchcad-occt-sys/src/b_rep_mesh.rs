// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_mesh.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type Message_ProgressRange = crate::message::Message_ProgressRange;

        type BRepMesh_IncrementalMesh;
        #[cxx_name = "construct_unique"]
        pub fn IncrementalMesh_new(
            shape: &TopoDS_Shape,
            deflection: f64,
        ) -> Result<UniquePtr<BRepMesh_IncrementalMesh>>;
        /// Meshes `shape` with a linear `deflection` (relative to each edge's size when
        /// `relative` is set) and an `angle` deflection in radians, using several threads when
        /// `parallel` is set. The algorithm stops early when `progress` asks it to.
        pub fn IncrementalMesh_with_parameters(
            shape: &TopoDS_Shape,
            deflection: f64,
            angle: f64,
            relative: bool,
            parallel: bool,
            progress: &Message_ProgressRange,
        ) -> Result<UniquePtr<BRepMesh_IncrementalMesh>>;
        pub fn Shape(self: &BRepMesh_IncrementalMesh) -> Result<&TopoDS_Shape>;
        pub fn IsDone(self: &BRepMesh_IncrementalMesh) -> bool;
    }
}
