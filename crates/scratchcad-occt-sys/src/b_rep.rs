// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep.hxx");

        type TopoDS_Builder = crate::topo_ds::TopoDS_Builder;
        type gp_Pnt = crate::gp::gp_Pnt;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type TopoDS_Edge = crate::topo_ds::TopoDS_Edge;
        type TopoDS_Vertex = crate::topo_ds::TopoDS_Vertex;
        type Handle_Geom_Surface = crate::geom::Handle_Geom_Surface;
        type Handle_Geom_Curve = crate::geom::Handle_Geom_Curve;
        type Handle_Poly_Triangulation = crate::poly::Handle_Poly_Triangulation;
        type TopLoc_Location = crate::top_loc::TopLoc_Location;

        type BRep_Builder;
        #[cxx_name = "construct_unique"]
        pub fn BRep_Builder_new() -> UniquePtr<BRep_Builder>;
        pub fn BRep_Builder_upcast_to_topods_builder(builder: &BRep_Builder) -> &TopoDS_Builder;

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;

        type BRep_Tool;
        /// Whether a wire or shell is closed (or an edge's vertices coincide).
        #[Self = "BRep_Tool"]
        pub fn IsClosed(shape: &TopoDS_Shape) -> bool;
        pub fn BRep_Tool_Surface(face: &TopoDS_Face) -> Result<UniquePtr<Handle_Geom_Surface>>;
        pub fn BRep_Tool_Curve(
            edge: &TopoDS_Edge,
            first: &mut f64,
            last: &mut f64,
        ) -> Result<UniquePtr<Handle_Geom_Curve>>;
        /// Whether the edge is a seam of the face, bounding it on both sides.
        pub fn BRep_Tool_IsClosed_on_face(edge: &TopoDS_Edge, face: &TopoDS_Face) -> bool;
        pub fn BRep_Tool_Pnt(vertex: &TopoDS_Vertex) -> Result<UniquePtr<gp_Pnt>>;
        pub fn BRep_Tool_Triangulation(
            face: &TopoDS_Face,
            location: Pin<&mut TopLoc_Location>,
        ) -> Result<UniquePtr<Handle_Poly_Triangulation>>;
    }
}
