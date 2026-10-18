// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/geom_api.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Vec = crate::gp::gp_Vec;
        type Handle_TColgp_HArray1OfPnt = crate::t_col_gp::Handle_TColgp_HArray1OfPnt;
        type Handle_Geom_BSplineCurve = crate::geom::Handle_Geom_BSplineCurve;
        type Handle_Geom_Surface = crate::geom::Handle_Geom_Surface;

        type GeomAPI_Interpolate;
        #[cxx_name = "construct_unique"]
        pub fn GeomAPI_Interpolate_new(
            points: &Handle_TColgp_HArray1OfPnt,
            periodic: bool,
            tolerance: f64,
        ) -> Result<UniquePtr<GeomAPI_Interpolate>>;
        pub fn Load(
            self: Pin<&mut GeomAPI_Interpolate>,
            initial_tangent: &gp_Vec,
            final_tangent: &gp_Vec,
            scale: bool,
        ) -> Result<()>;
        pub fn Perform(self: Pin<&mut GeomAPI_Interpolate>) -> Result<()>;
        pub fn GeomAPI_Interpolate_Curve(
            interpolate: &GeomAPI_Interpolate,
        ) -> Result<UniquePtr<Handle_Geom_BSplineCurve>>;

        type GeomAPI_ProjectPointOnSurf;
        #[cxx_name = "construct_unique"]
        pub fn GeomAPI_ProjectPointOnSurf_new(
            origin: &gp_Pnt,
            surface: &Handle_Geom_Surface,
        ) -> Result<UniquePtr<GeomAPI_ProjectPointOnSurf>>;
        pub fn NbPoints(self: &GeomAPI_ProjectPointOnSurf) -> i32;
        /// The (u, v) parameters of the nearest projection. Fails with `StdFail_NotDone` when
        /// the projection found no solution.
        pub fn GeomAPI_ProjectPointOnSurf_LowerDistanceParameters(
            projector: &GeomAPI_ProjectPointOnSurf,
            u: &mut f64,
            v: &mut f64,
        ) -> Result<()>;
    }
}
