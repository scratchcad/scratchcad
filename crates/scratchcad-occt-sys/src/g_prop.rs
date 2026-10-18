// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/g_prop.hxx");

        type gp_Ax1 = crate::gp::gp_Ax1;
        type gp_Pnt = crate::gp::gp_Pnt;

        type GProp_GProps;
        #[cxx_name = "construct_unique"]
        pub fn GProps_new() -> UniquePtr<GProp_GProps>;
        pub fn Mass(self: &GProp_GProps) -> f64;
        pub fn StaticMoments(self: &GProp_GProps, lx: &mut f64, ly: &mut f64, lz: &mut f64);
        pub fn MomentOfInertia(self: &GProp_GProps, axis: &gp_Ax1) -> f64;
        pub fn RadiusOfGyration(self: &GProp_GProps, axis: &gp_Ax1) -> f64;
        pub fn GProp_GProps_CentreOfMass(props: &GProp_GProps) -> UniquePtr<gp_Pnt>;
    }
}
