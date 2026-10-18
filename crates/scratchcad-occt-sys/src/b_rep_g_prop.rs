// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_g_prop.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Vec = crate::gp::gp_Vec;
        type GProp_GProps = crate::g_prop::GProp_GProps;

        type BRepGProp;
        #[Self = "BRepGProp"]
        pub fn LinearProperties(
            shape: &TopoDS_Shape,
            props: Pin<&mut GProp_GProps>,
            skip_shared: bool,
            use_triangulation: bool,
        ) -> Result<()>;
        #[Self = "BRepGProp"]
        pub fn SurfaceProperties(
            shape: &TopoDS_Shape,
            props: Pin<&mut GProp_GProps>,
            skip_shared: bool,
            use_triangulation: bool,
        ) -> Result<()>;
        #[Self = "BRepGProp"]
        pub fn VolumeProperties(
            shape: &TopoDS_Shape,
            props: Pin<&mut GProp_GProps>,
            only_closed: bool,
            skip_shared: bool,
            use_triangulation: bool,
        ) -> Result<()>;

        type BRepGProp_Face;
        #[cxx_name = "construct_unique"]
        pub fn BRepGProp_Face_new(face: &TopoDS_Face) -> Result<UniquePtr<BRepGProp_Face>>;
        pub fn Normal(
            self: &BRepGProp_Face,
            u: f64,
            v: f64,
            point: Pin<&mut gp_Pnt>,
            normal: Pin<&mut gp_Vec>,
        ) -> Result<()>;
    }
}
