// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/shape_upgrade.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;

        type ShapeUpgrade_UnifySameDomain;
        #[cxx_name = "construct_unique"]
        pub fn UnifySameDomain_new(
            shape: &TopoDS_Shape,
            unify_edges: bool,
            unify_faces: bool,
            concat_b_splines: bool,
        ) -> Result<UniquePtr<ShapeUpgrade_UnifySameDomain>>;
        #[cxx_name = "AllowInternalEdges"]
        pub fn allow_internal_edges(self: Pin<&mut ShapeUpgrade_UnifySameDomain>, allow: bool);
        #[cxx_name = "Build"]
        pub fn build(self: Pin<&mut ShapeUpgrade_UnifySameDomain>) -> Result<()>;
        #[cxx_name = "Shape"]
        pub fn shape(self: &ShapeUpgrade_UnifySameDomain) -> Result<&TopoDS_Shape>;
    }
}
