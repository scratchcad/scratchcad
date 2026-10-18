// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_bnd_lib.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type Bnd_Box = crate::bnd::Bnd_Box;

        type BRepBndLib;
        #[Self = "BRepBndLib"]
        pub fn Add(
            shape: &TopoDS_Shape,
            bb: Pin<&mut Bnd_Box>,
            use_triangulation: bool,
        ) -> Result<()>;

        /// A tighter box than [`Add`]: uses the exact geometry instead of control polygons.
        #[Self = "BRepBndLib"]
        pub fn AddOptimal(
            shape: &TopoDS_Shape,
            bb: Pin<&mut Bnd_Box>,
            use_triangulation: bool,
            use_shape_tolerance: bool,
        ) -> Result<()>;
    }
}
