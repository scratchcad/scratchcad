// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/bnd.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;

        // Describes a bounding box in 3D space.
        type Bnd_Box;
        #[cxx_name = "construct_unique"]
        pub fn Bnd_Box_new() -> UniquePtr<Bnd_Box>;
        pub fn IsVoid(self: &Bnd_Box) -> bool;
        pub fn Get(
            self: &Bnd_Box,
            xMin: &mut f64,
            yMin: &mut f64,
            zMin: &mut f64,
            xMax: &mut f64,
            yMax: &mut f64,
            zMax: &mut f64,
        ) -> Result<()>;
        pub fn Bnd_Box_CornerMin(b: &Bnd_Box) -> Result<UniquePtr<gp_Pnt>>;
        pub fn Bnd_Box_CornerMax(b: &Bnd_Box) -> Result<UniquePtr<gp_Pnt>>;
        pub fn GetGap(self: &Bnd_Box) -> f64;
        pub fn Set(self: Pin<&mut Bnd_Box>, p: &gp_Pnt) -> Result<()>;
        pub fn SetGap(self: Pin<&mut Bnd_Box>, gap: f64);
    }
}
