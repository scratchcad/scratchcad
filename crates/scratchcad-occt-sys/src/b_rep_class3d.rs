//! Point classification against solids (OpenCASCADE's `BRepClass3d` package).

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_class3d.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type gp_Pnt = crate::gp::gp_Pnt;
        type TopAbs_State = crate::top_abs::TopAbs_State;

        /// Whether `point` lies inside (`TopAbs_IN`), outside (`TopAbs_OUT`) or on the boundary
        /// (`TopAbs_ON`, within `tolerance`) of `solid`.
        pub fn classify_point(
            solid: &TopoDS_Shape,
            point: &gp_Pnt,
            tolerance: f64,
        ) -> Result<TopAbs_State>;
    }
}
