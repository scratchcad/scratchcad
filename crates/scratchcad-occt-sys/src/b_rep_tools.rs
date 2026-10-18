// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_tools.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type TopoDS_Wire = crate::topo_ds::TopoDS_Wire;
        type Message_ProgressRange = crate::message::Message_ProgressRange;

        type BRepTools;

        pub fn outer_wire(face: &TopoDS_Face) -> Result<UniquePtr<TopoDS_Wire>>;

        #[cxx_name = "write_brep_text"]
        pub fn write(shape: &TopoDS_Shape, path: String) -> Result<bool>;
        #[cxx_name = "read_brep_text"]
        pub fn read(path: String) -> Result<UniquePtr<TopoDS_Shape>>;

        /// The shape in OpenCASCADE's text BREP format.
        pub fn write_brep_bytes(
            shape: &TopoDS_Shape,
            progress: &Message_ProgressRange,
        ) -> Result<UniquePtr<CxxString>>;
        /// Reads a shape in the text BREP format from memory; null if there is none.
        pub fn read_brep_bytes(
            bytes: &[u8],
            progress: &Message_ProgressRange,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
    }
}
