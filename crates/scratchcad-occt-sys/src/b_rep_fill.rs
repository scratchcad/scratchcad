//! Helpers for smooth lofts: their sections as compatible B-splines, and the faces and solid of a
//! loft surface built through them.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_fill.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopTools_ListOfShape = crate::top_tools::TopTools_ListOfShape;

        /// The sections of a loft as B-spline curves with a common degree and knots.
        type LoftSections;
        pub fn degree(self: &LoftSections) -> i32;
        /// How many edges each section has (after matching), each spanning 1 in u.
        pub fn edge_count(self: &LoftSections) -> i32;
        pub fn section_count(self: &LoftSections) -> i32;
        /// How many poles each section's curve has.
        pub fn pole_count(self: &LoftSections) -> i32;
        pub fn is_closed(self: &LoftSections) -> bool;
        pub fn knot_values(self: &LoftSections) -> &CxxVector<f64>;
        pub fn knot_mults(self: &LoftSections) -> &CxxVector<i32>;
        /// x, y and z of every pole, section by section.
        pub fn pole_coords(self: &LoftSections) -> &CxxVector<f64>;
        pub fn pole_weights(self: &LoftSections) -> &CxxVector<f64>;

        /// The wires as compatible B-splines of degree 3 or more, edge `j` running over
        /// `[j, j + 1]`, conics exactly.
        /// With `match_edges`, they are first given the same number of edges and matching
        /// starting points (`BRepFill_CompatibleWires`). Throws on an offset curve, which has no
        /// exact B-spline form, or on wires that can't be matched up.
        pub fn BRepFill_loft_sections(
            wires: &TopTools_ListOfShape,
            match_edges: bool,
        ) -> Result<UniquePtr<LoftSections>>;

        /// The faces of the B-spline surface given by its degrees, knots, multiplicities, poles
        /// (x, y, z, u index major) and weights: one per unit span in u (`edges` of them) and per
        /// stretch between consecutive `cuts` in v, with shared exact edges, closed into a solid
        /// by planar end faces if `solid`. Throws if an end isn't planar, or isn't closed.
        #[allow(clippy::too_many_arguments)]
        pub fn BRepFill_loft_shape(
            u_degree: i32,
            u_knots: &[f64],
            u_mults: &[i32],
            v_degree: i32,
            v_knots: &[f64],
            v_mults: &[i32],
            poles: &[f64],
            weights: &[f64],
            edges: i32,
            closed: bool,
            cuts: &[f64],
            solid: bool,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
    }
}
