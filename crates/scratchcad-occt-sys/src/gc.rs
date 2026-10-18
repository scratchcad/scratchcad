// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/gc.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Pnt2d = crate::gp::gp_Pnt2d;
        type Handle_Geom_TrimmedCurve = crate::geom::Handle_Geom_TrimmedCurve;
        type Handle_Geom2d_TrimmedCurve = crate::geom2d::Handle_Geom2d_TrimmedCurve;

        type GC_MakeSegment;
        /// Fails with `Standard_ConstructionError` for coincident points (OCCT itself would
        /// dereference a null line).
        pub fn GC_MakeSegment_point_point(
            p1: &gp_Pnt,
            p2: &gp_Pnt,
        ) -> Result<UniquePtr<GC_MakeSegment>>;
        pub fn GC_MakeSegment_Value(
            arc: &GC_MakeSegment,
        ) -> Result<UniquePtr<Handle_Geom_TrimmedCurve>>;

        type GCE2d_MakeSegment;
        pub fn GCE2d_MakeSegment_point_point(
            p1: &gp_Pnt2d,
            p2: &gp_Pnt2d,
        ) -> Result<UniquePtr<Handle_Geom2d_TrimmedCurve>>;

        type GC_MakeArcOfCircle;
        #[cxx_name = "construct_unique"]
        pub fn GC_MakeArcOfCircle_point_point_point(
            p1: &gp_Pnt,
            p2: &gp_Pnt,
            p3: &gp_Pnt,
        ) -> Result<UniquePtr<GC_MakeArcOfCircle>>;
        pub fn GC_MakeArcOfCircle_Value(
            arc: &GC_MakeArcOfCircle,
        ) -> Result<UniquePtr<Handle_Geom_TrimmedCurve>>;
    }
}
