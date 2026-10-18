// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_builder_api.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Circ = crate::gp::gp_Circ;
        type gp_Trsf = crate::gp::gp_Trsf;
        type gp_GTrsf = crate::gp::gp_GTrsf;
        type Message_ProgressRange = crate::message::Message_ProgressRange;
        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Vertex = crate::topo_ds::TopoDS_Vertex;
        type TopoDS_Edge = crate::topo_ds::TopoDS_Edge;
        type TopoDS_Wire = crate::topo_ds::TopoDS_Wire;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type TopoDS_Shell = crate::topo_ds::TopoDS_Shell;
        type Handle_Geom_Curve = crate::geom::Handle_Geom_Curve;
        type Handle_Geom_Surface = crate::geom::Handle_Geom_Surface;
        type Handle_Geom2d_Curve = crate::geom2d::Handle_Geom2d_Curve;
        type Handle_Poly_Triangulation = crate::poly::Handle_Poly_Triangulation;

        type BRepBuilderAPI_MakeVertex;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeVertex_gp_Pnt(
            point: &gp_Pnt,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeVertex>>;
        pub fn Vertex(self: Pin<&mut BRepBuilderAPI_MakeVertex>) -> Result<&TopoDS_Vertex>;

        type BRepBuilderAPI_MakeEdge;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeEdge_HandleGeomCurve(
            geom_curve_handle: &Handle_Geom_Curve,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeEdge>>;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeEdge_circle(
            circle: &gp_Circ,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeEdge>>;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(
            p1: &gp_Pnt,
            p2: &gp_Pnt,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeEdge>>;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeEdge_CurveSurface2d(
            curve_handle: &Handle_Geom2d_Curve,
            surface_handle: &Handle_Geom_Surface,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeEdge>>;
        pub fn Vertex1(self: &BRepBuilderAPI_MakeEdge) -> Result<&TopoDS_Vertex>;
        pub fn Edge(self: Pin<&mut BRepBuilderAPI_MakeEdge>) -> Result<&TopoDS_Edge>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_MakeEdge>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_MakeEdge) -> bool;

        type BRepBuilderAPI_MakeWire;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeWire_new() -> UniquePtr<BRepBuilderAPI_MakeWire>;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeWire_edge_edge(
            edge_1: &TopoDS_Edge,
            edge_2: &TopoDS_Edge,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeWire>>;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeWire_edge_edge_edge(
            edge_1: &TopoDS_Edge,
            edge_2: &TopoDS_Edge,
            edge_3: &TopoDS_Edge,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeWire>>;
        #[rust_name = "add_edge"]
        pub fn Add(self: Pin<&mut BRepBuilderAPI_MakeWire>, edge: &TopoDS_Edge) -> Result<()>;
        #[rust_name = "add_wire"]
        pub fn Add(self: Pin<&mut BRepBuilderAPI_MakeWire>, wire: &TopoDS_Wire) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepBuilderAPI_MakeWire>) -> Result<&TopoDS_Shape>;
        pub fn Wire(self: Pin<&mut BRepBuilderAPI_MakeWire>) -> Result<&TopoDS_Wire>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_MakeWire>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_MakeWire) -> bool;

        type BRepBuilderAPI_MakeFace;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeFace_wire(
            wire: &TopoDS_Wire,
            only_plane: bool,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeFace>>;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeFace_surface(
            surface: &Handle_Geom_Surface,
            edge_tolerance: f64,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeFace>>;
        pub fn Face(self: &BRepBuilderAPI_MakeFace) -> Result<&TopoDS_Face>;
        pub fn Shape(self: Pin<&mut BRepBuilderAPI_MakeFace>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_MakeFace>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_MakeFace) -> bool;
        #[rust_name = "add_wire"]
        pub fn Add(self: Pin<&mut BRepBuilderAPI_MakeFace>, wire: &TopoDS_Wire) -> Result<()>;

        type BRepBuilderAPI_MakeSolid;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeSolid_new(
            shell: &TopoDS_Shell,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeSolid>>;
        pub fn Shape(self: Pin<&mut BRepBuilderAPI_MakeSolid>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_MakeSolid>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_MakeSolid) -> bool;

        type BRepBuilderAPI_MakeShapeOnMesh;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_MakeShapeOnMesh_new(
            mesh: &Handle_Poly_Triangulation,
        ) -> Result<UniquePtr<BRepBuilderAPI_MakeShapeOnMesh>>;
        pub fn Shape(self: Pin<&mut BRepBuilderAPI_MakeShapeOnMesh>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_MakeShapeOnMesh>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_MakeShapeOnMesh) -> bool;

        type BRepBuilderAPI_Transform;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_Transform_new(
            shape: &TopoDS_Shape,
            transform: &gp_Trsf,
            copy: bool,
        ) -> Result<UniquePtr<BRepBuilderAPI_Transform>>;
        pub fn Shape(self: Pin<&mut BRepBuilderAPI_Transform>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_Transform>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_Transform) -> bool;

        type BRepBuilderAPI_GTransform;
        #[cxx_name = "construct_unique"]
        pub fn BRepBuilderAPI_GTransform_new(
            shape: &TopoDS_Shape,
            transform: &gp_GTrsf,
            copy: bool,
        ) -> Result<UniquePtr<BRepBuilderAPI_GTransform>>;
        pub fn Shape(self: Pin<&mut BRepBuilderAPI_GTransform>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepBuilderAPI_GTransform>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepBuilderAPI_GTransform) -> bool;

        /// A copy of `shape` sharing no topology or geometry with it (triangulations are not
        /// copied). Sub-shapes keep their exploration order.
        pub fn BRepBuilderAPI_copy_shape(shape: &TopoDS_Shape) -> Result<UniquePtr<TopoDS_Shape>>;
    }
}
