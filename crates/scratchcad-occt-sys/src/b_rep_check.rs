pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_check.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;

        type BRepCheck_Analyzer;

        /// Runs the full topological and geometric validity check on `shape`.
        #[cxx_name = "construct_unique"]
        pub fn BRepCheck_Analyzer_new(
            shape: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepCheck_Analyzer>>;
        pub fn IsValid(self: &BRepCheck_Analyzer) -> bool;
    }
}
