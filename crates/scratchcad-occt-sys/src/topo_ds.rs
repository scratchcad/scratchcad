// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/topo_ds.hxx");

        type TopLoc_Location = crate::top_loc::TopLoc_Location;
        type TopAbs_ShapeEnum = crate::top_abs::TopAbs_ShapeEnum;
        type TopAbs_Orientation = crate::top_abs::TopAbs_Orientation;
        type TopTools_ListOfShape = crate::top_tools::TopTools_ListOfShape;

        /// Down-casts. Each fails with `Standard_TypeMismatch` when the shape is of another type.
        type TopoDS;
        #[Self = "TopoDS"]
        pub fn Vertex(shape: &TopoDS_Shape) -> Result<&TopoDS_Vertex>;
        #[Self = "TopoDS"]
        pub fn Edge(shape: &TopoDS_Shape) -> Result<&TopoDS_Edge>;
        #[Self = "TopoDS"]
        pub fn Wire(shape: &TopoDS_Shape) -> Result<&TopoDS_Wire>;
        #[Self = "TopoDS"]
        pub fn Face(shape: &TopoDS_Shape) -> Result<&TopoDS_Face>;
        #[Self = "TopoDS"]
        pub fn Shell(shape: &TopoDS_Shape) -> Result<&TopoDS_Shell>;
        #[Self = "TopoDS"]
        pub fn Solid(shape: &TopoDS_Shape) -> Result<&TopoDS_Solid>;
        #[Self = "TopoDS"]
        pub fn Compound(shape: &TopoDS_Shape) -> Result<&TopoDS_Compound>;

        type TopoDS_Vertex;
        #[cxx_name = "upcast_ref"]
        pub fn cast_vertex_to_shape(wire: &TopoDS_Vertex) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Vertex_to_owned(shape: &TopoDS_Vertex) -> UniquePtr<TopoDS_Vertex>;

        type TopoDS_Edge;
        #[cxx_name = "upcast_ref"]
        pub fn cast_edge_to_shape(wire: &TopoDS_Edge) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Edge_to_owned(shape: &TopoDS_Edge) -> UniquePtr<TopoDS_Edge>;

        type TopoDS_Wire;
        #[cxx_name = "upcast_ref"]
        pub fn cast_wire_to_shape(wire: &TopoDS_Wire) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Wire_to_owned(shape: &TopoDS_Wire) -> UniquePtr<TopoDS_Wire>;

        type TopoDS_Face;
        #[cxx_name = "upcast_ref"]
        pub fn cast_face_to_shape(wire: &TopoDS_Face) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Face_new() -> UniquePtr<TopoDS_Face>;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Face_to_owned(shape: &TopoDS_Face) -> UniquePtr<TopoDS_Face>;
        pub fn Orientation(self: &TopoDS_Face) -> TopAbs_Orientation;

        type TopoDS_Shell;
        #[cxx_name = "upcast_ref"]
        pub fn cast_shell_to_shape(wire: &TopoDS_Shell) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Shell_new() -> UniquePtr<TopoDS_Shell>;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Shell_to_owned(shape: &TopoDS_Shell) -> UniquePtr<TopoDS_Shell>;
        #[cxx_name = "upcast"]
        pub fn TopoDS_Shell_as_shape(shell: UniquePtr<TopoDS_Shell>) -> UniquePtr<TopoDS_Shape>;

        type TopoDS_Solid;
        #[cxx_name = "upcast_ref"]
        pub fn cast_solid_to_shape(wire: &TopoDS_Solid) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Solid_to_owned(shape: &TopoDS_Solid) -> UniquePtr<TopoDS_Solid>;

        type TopoDS_Shape;
        /// A null shape.
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Shape_new() -> UniquePtr<TopoDS_Shape>;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Shape_to_owned(shape: &TopoDS_Shape) -> UniquePtr<TopoDS_Shape>;
        #[cxx_name = "Move"]
        pub fn translate(
            self: Pin<&mut TopoDS_Shape>,
            position: &TopLoc_Location,
            raise_exception: bool,
        ) -> Result<()>;
        #[cxx_name = "Location"]
        pub fn set_global_translation(
            self: Pin<&mut TopoDS_Shape>,
            translation: &TopLoc_Location,
            raise_exception: bool,
        ) -> Result<()>;
        pub fn IsNull(self: &TopoDS_Shape) -> bool;
        pub fn IsEqual(self: &TopoDS_Shape, other: &TopoDS_Shape) -> bool;
        pub fn IsSame(self: &TopoDS_Shape, other: &TopoDS_Shape) -> bool;
        pub fn NbChildren(self: &TopoDS_Shape) -> i32;
        pub fn Closed(self: &TopoDS_Shape) -> bool;
        pub fn ShapeType(self: &TopoDS_Shape) -> TopAbs_ShapeEnum;
        pub fn Orientation(self: &TopoDS_Shape) -> TopAbs_Orientation;

        type TopoDS_Compound;
        #[cxx_name = "upcast_ref"]
        pub fn cast_compound_to_shape(wire: &TopoDS_Compound) -> &TopoDS_Shape;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Compound_new() -> UniquePtr<TopoDS_Compound>;
        #[cxx_name = "construct_unique"]
        pub fn TopoDS_Compound_to_owned(shape: &TopoDS_Compound) -> UniquePtr<TopoDS_Compound>;
        #[cxx_name = "upcast"]
        pub fn TopoDS_Compound_as_shape(
            compound: UniquePtr<TopoDS_Compound>,
        ) -> UniquePtr<TopoDS_Shape>;

        type TopoDS_Builder;
        pub fn MakeCompound(self: &TopoDS_Builder, compound: Pin<&mut TopoDS_Compound>);
        pub fn MakeShell(self: &TopoDS_Builder, shell: Pin<&mut TopoDS_Shell>);
        /// Fails with `TopoDS_UnCompatibleShapes` when `child` cannot be added to `shape`.
        pub fn Add(
            self: &TopoDS_Builder,
            shape: Pin<&mut TopoDS_Shape>,
            child: &TopoDS_Shape,
        ) -> Result<()>;

        // This is dumb:
        // https://cxx.rs/extern-c++.html#explicit-shim-trait-impls
        #[cxx_name = "list_to_vector"]
        pub fn shape_list_to_vector(
            list: &TopTools_ListOfShape,
        ) -> UniquePtr<CxxVector<TopoDS_Shape>>;
    }
}

unsafe impl Send for inner::TopoDS_Vertex {}
unsafe impl Send for inner::TopoDS_Edge {}
unsafe impl Send for inner::TopoDS_Wire {}
unsafe impl Send for inner::TopoDS_Face {}
unsafe impl Send for inner::TopoDS_Shell {}
unsafe impl Send for inner::TopoDS_Solid {}
unsafe impl Send for inner::TopoDS_Compound {}
unsafe impl Send for inner::TopoDS_Shape {}
