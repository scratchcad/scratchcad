// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_adaptor.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Vec = crate::gp::gp_Vec;
        type gp_Circ = crate::gp::gp_Circ;
        type GeomAbs_CurveType = crate::geom_abs::GeomAbs_CurveType;
        type GeomAbs_SurfaceType = crate::geom_abs::GeomAbs_SurfaceType;
        type TopoDS_Edge = crate::topo_ds::TopoDS_Edge;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;

        type BRepAdaptor_Curve;

        /// Fails with `Standard_NullObject` when OCCT finds no geometry for the edge.
        #[cxx_name = "construct_unique"]
        pub fn BRepAdaptor_Curve_new(edge: &TopoDS_Edge) -> Result<UniquePtr<BRepAdaptor_Curve>>;
        pub fn FirstParameter(self: &BRepAdaptor_Curve) -> f64;
        pub fn LastParameter(self: &BRepAdaptor_Curve) -> f64;
        pub fn BRepAdaptor_Curve_value(
            curve: &BRepAdaptor_Curve,
            u: f64,
        ) -> Result<UniquePtr<gp_Pnt>>;
        pub fn GetType(self: &BRepAdaptor_Curve) -> GeomAbs_CurveType;
        pub fn IsClosed(self: &BRepAdaptor_Curve) -> bool;
        /// The point and first derivative at parameter `u`.
        pub fn D1(
            self: &BRepAdaptor_Curve,
            u: f64,
            point: Pin<&mut gp_Pnt>,
            tangent: Pin<&mut gp_Vec>,
        ) -> Result<()>;
        /// Fails with `Standard_NoSuchObject` unless the curve is a circle.
        pub fn BRepAdaptor_Curve_circle(curve: &BRepAdaptor_Curve) -> Result<UniquePtr<gp_Circ>>;

        type BRepAdaptor_Surface;

        /// `restriction` limits the parametric bounds to the face's boundaries.
        #[cxx_name = "construct_unique"]
        pub fn BRepAdaptor_Surface_new(
            face: &TopoDS_Face,
            restriction: bool,
        ) -> Result<UniquePtr<BRepAdaptor_Surface>>;
        pub fn GetType(self: &BRepAdaptor_Surface) -> GeomAbs_SurfaceType;
        pub fn FirstUParameter(self: &BRepAdaptor_Surface) -> f64;
        pub fn LastUParameter(self: &BRepAdaptor_Surface) -> f64;
        pub fn FirstVParameter(self: &BRepAdaptor_Surface) -> f64;
        pub fn LastVParameter(self: &BRepAdaptor_Surface) -> f64;
        pub fn BRepAdaptor_Surface_value(
            surface: &BRepAdaptor_Surface,
            u: f64,
            v: f64,
        ) -> Result<UniquePtr<gp_Pnt>>;
        /// How many pieces the surface is smooth on, with no break in any derivative, within
        /// the adaptor's parameter range: 1 for an analytic surface or a Bézier patch, one per
        /// knot span for a B-spline.
        pub fn BRepAdaptor_Surface_smooth_patches(surface: &BRepAdaptor_Surface) -> Result<i32>;
    }
}
