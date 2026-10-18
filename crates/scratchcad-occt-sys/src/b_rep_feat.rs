// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_feat.hxx");

        type gp_Ax1 = crate::gp::gp_Ax1;
        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;

        type BRepFeat_MakeDPrism;
        #[cxx_name = "construct_unique"]
        pub fn BRepFeat_MakeDPrism_new(
            shape: &TopoDS_Shape,
            profile_base: &TopoDS_Face,
            sketch_base: &TopoDS_Face,
            angle: f64,
            fuse: i32, // 0 = subtractive, 1 = additive
            modify: bool,
        ) -> Result<UniquePtr<BRepFeat_MakeDPrism>>;

        #[cxx_name = "Perform"]
        pub fn perform_until_face(
            self: Pin<&mut BRepFeat_MakeDPrism>,
            until: &TopoDS_Shape,
        ) -> Result<()>;
        #[cxx_name = "Perform"]
        pub fn perform_with_height(self: Pin<&mut BRepFeat_MakeDPrism>, height: f64) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepFeat_MakeDPrism>) -> Result<&TopoDS_Shape>;

        type BRepFeat_MakeCylindricalHole;
        #[cxx_name = "construct_unique"]
        pub fn BRepFeat_MakeCylindricalHole_new() -> UniquePtr<BRepFeat_MakeCylindricalHole>;
        pub fn Init(
            self: Pin<&mut BRepFeat_MakeCylindricalHole>,
            shape: &TopoDS_Shape,
            axis: &gp_Ax1,
        ) -> Result<()>;
        pub fn Perform(self: Pin<&mut BRepFeat_MakeCylindricalHole>, radius: f64) -> Result<()>;
        pub fn Build(self: Pin<&mut BRepFeat_MakeCylindricalHole>) -> Result<()>;
        pub fn Shape(self: &BRepFeat_MakeCylindricalHole) -> Result<&TopoDS_Shape>;
    }
}
