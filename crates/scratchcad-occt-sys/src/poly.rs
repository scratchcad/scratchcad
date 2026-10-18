// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/poly.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Pnt2d = crate::gp::gp_Pnt2d;
        type gp_Dir = crate::gp::gp_Dir;
        type BRepAdaptor_Curve = crate::b_rep_adaptor::BRepAdaptor_Curve;

        // Handles
        type Handle_Poly_Triangulation;
        pub fn IsNull(self: &Handle_Poly_Triangulation) -> bool;
        #[cxx_name = "handle_try_deref"]
        pub fn Handle_Poly_Triangulation_Get(
            handle: &Handle_Poly_Triangulation,
        ) -> Result<&Poly_Triangulation>;
        // End Handles

        type Poly_Triangulation;
        #[cxx_name = "construct_unique"]
        pub fn Triangulation_new(
            nb_nodes: i32,
            nb_triangles: i32,
            has_uv: bool,
            has_normals: bool,
        ) -> UniquePtr<Poly_Triangulation>;
        pub fn NbNodes(self: &Poly_Triangulation) -> i32;
        pub fn NbTriangles(self: &Poly_Triangulation) -> i32;
        pub fn HasNormals(self: &Poly_Triangulation) -> bool;
        pub fn HasUVNodes(self: &Poly_Triangulation) -> bool;
        pub fn Triangle(self: &Poly_Triangulation, index: i32) -> Result<&Poly_Triangle>;
        pub fn SetTriangle(
            self: Pin<&mut Poly_Triangulation>,
            index: i32,
            triangle: &Poly_Triangle,
        ) -> Result<()>;
        pub fn SetNode(self: Pin<&mut Poly_Triangulation>, index: i32, node: &gp_Pnt)
            -> Result<()>;
        pub fn SetNormal(
            self: Pin<&mut Poly_Triangulation>,
            index: i32,
            dir: &gp_Dir,
        ) -> Result<()>;
        pub fn SetUVNode(
            self: Pin<&mut Poly_Triangulation>,
            index: i32,
            uv: &gp_Pnt2d,
        ) -> Result<()>;
        pub fn Poly_Triangulation_Normal(
            triangulation: &Poly_Triangulation,
            index: i32,
        ) -> Result<UniquePtr<gp_Dir>>;
        pub fn Poly_Triangulation_Node(
            triangulation: &Poly_Triangulation,
            index: i32,
        ) -> Result<UniquePtr<gp_Pnt>>;
        pub fn Poly_Triangulation_UV(
            triangulation: &Poly_Triangulation,
            index: i32,
        ) -> Result<UniquePtr<gp_Pnt2d>>;

        type Poly_Triangle;
        #[cxx_name = "construct_unique"]
        pub fn Triangle_new(node1: i32, node2: i32, node3: i32) -> UniquePtr<Poly_Triangle>;
        pub fn Value(self: &Poly_Triangle, index: i32) -> Result<i32>;

        type Poly_Connect;
        #[cxx_name = "construct_unique"]
        pub fn Connect_new(
            triangulation: &Handle_Poly_Triangulation,
        ) -> Result<UniquePtr<Poly_Connect>>;

        pub fn Handle_Poly_Triangulation_new(
            triangulation: UniquePtr<Poly_Triangulation>,
        ) -> UniquePtr<Handle_Poly_Triangulation>;
    }

    impl UniquePtr<Handle_Poly_Triangulation> {}
}
