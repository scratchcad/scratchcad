// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_lib.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type Handle_Poly_Triangulation = crate::poly::Handle_Poly_Triangulation;

        type BRepLib;
        #[Self = "BRepLib"]
        pub fn BuildCurves3d(shape: &TopoDS_Shape) -> Result<bool>;

        type BRepLib_ToolTriangulatedShape;
        #[Self = "BRepLib_ToolTriangulatedShape"]
        pub fn ComputeNormals(
            face: &TopoDS_Face,
            triangulation: &Handle_Poly_Triangulation,
        ) -> Result<()>;
    }
}
