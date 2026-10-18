// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_fillet_api.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Edge = crate::topo_ds::TopoDS_Edge;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type TopoDS_Vertex = crate::topo_ds::TopoDS_Vertex;
        type TColgp_Array1OfPnt2d = crate::t_col_gp::TColgp_Array1OfPnt2d;
        type Message_ProgressRange = crate::message::Message_ProgressRange;

        type BRepFilletAPI_MakeFillet;
        #[cxx_name = "construct_unique"]
        pub fn BRepFilletAPI_MakeFillet_new(
            shape: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepFilletAPI_MakeFillet>>;
        #[rust_name = "add_edge"]
        pub fn Add(
            self: Pin<&mut BRepFilletAPI_MakeFillet>,
            radius: f64,
            edge: &TopoDS_Edge,
        ) -> Result<()>;
        #[rust_name = "variable_add_edge"]
        pub fn Add(
            self: Pin<&mut BRepFilletAPI_MakeFillet>,
            radius_values: &TColgp_Array1OfPnt2d,
            edge: &TopoDS_Edge,
        ) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepFilletAPI_MakeFillet>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepFilletAPI_MakeFillet>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepFilletAPI_MakeFillet) -> bool;

        type BRepFilletAPI_MakeFillet2d;
        #[cxx_name = "construct_unique"]
        pub fn BRepFilletAPI_MakeFillet2d_new(
            face: &TopoDS_Face,
        ) -> Result<UniquePtr<BRepFilletAPI_MakeFillet2d>>;
        pub fn BRepFilletAPI_MakeFillet2d_add_fillet(
            make_fillet: Pin<&mut BRepFilletAPI_MakeFillet2d>,
            vertex: &TopoDS_Vertex,
            radius: f64,
        ) -> Result<UniquePtr<TopoDS_Edge>>;
        pub fn BRepFilletAPI_MakeFillet2d_add_chamfer(
            make_fillet: Pin<&mut BRepFilletAPI_MakeFillet2d>,
            edge1: &TopoDS_Edge,
            edge2: &TopoDS_Edge,
            distance1: f64,
            distance2: f64,
        ) -> Result<UniquePtr<TopoDS_Edge>>;
        pub fn BRepFilletAPI_MakeFillet2d_add_chamfer_angle(
            make_fillet: Pin<&mut BRepFilletAPI_MakeFillet2d>,
            edge: &TopoDS_Edge,
            vertex: &TopoDS_Vertex,
            distance: f64,
            angle: f64,
        ) -> Result<UniquePtr<TopoDS_Edge>>;
        pub fn Build(
            self: Pin<&mut BRepFilletAPI_MakeFillet2d>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepFilletAPI_MakeFillet2d>) -> Result<&TopoDS_Shape>;
        pub fn IsDone(self: &BRepFilletAPI_MakeFillet2d) -> bool;

        type BRepFilletAPI_MakeChamfer;
        #[cxx_name = "construct_unique"]
        pub fn BRepFilletAPI_MakeChamfer_new(
            shape: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepFilletAPI_MakeChamfer>>;
        #[rust_name = "add_edge"]
        pub fn Add(
            self: Pin<&mut BRepFilletAPI_MakeChamfer>,
            distance: f64,
            edge: &TopoDS_Edge,
        ) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepFilletAPI_MakeChamfer>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepFilletAPI_MakeChamfer>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepFilletAPI_MakeChamfer) -> bool;
    }
}
