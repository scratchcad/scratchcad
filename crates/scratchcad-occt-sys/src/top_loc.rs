// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/top_loc.hxx");

        type gp_Trsf = crate::gp::gp_Trsf;

        type TopLoc_Location;
        #[cxx_name = "construct_unique"]
        pub fn Location_new() -> UniquePtr<TopLoc_Location>;
        #[cxx_name = "construct_unique"]
        pub fn Location_from_transform(transform: &gp_Trsf) -> UniquePtr<TopLoc_Location>;
        pub fn TopLoc_Location_Transformation(location: &TopLoc_Location) -> UniquePtr<gp_Trsf>;
    }
}
