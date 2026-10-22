// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_algo_api.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopTools_ListOfShape = crate::top_tools::TopTools_ListOfShape;
        type Message_ProgressRange = crate::message::Message_ProgressRange;
        type BOPAlgo_GlueEnum = crate::bop_algo::BOPAlgo_GlueEnum;

        pub type BRepAlgoAPI_Fuse;
        #[cxx_name = "construct_unique"]
        pub fn BRepAlgoAPI_Fuse_new(
            shape_1: &TopoDS_Shape,
            shape_2: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepAlgoAPI_Fuse>>;
        pub fn Shape(self: Pin<&mut BRepAlgoAPI_Fuse>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepAlgoAPI_Fuse>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepAlgoAPI_Fuse) -> bool;
        pub fn SectionEdges(self: Pin<&mut BRepAlgoAPI_Fuse>) -> Result<&TopTools_ListOfShape>;
        pub fn SetGlue(self: Pin<&mut BRepAlgoAPI_Fuse>, glue: BOPAlgo_GlueEnum);

        type BRepAlgoAPI_Cut;
        #[cxx_name = "construct_unique"]
        pub fn BRepAlgoAPI_Cut_new(
            shape_1: &TopoDS_Shape,
            shape_2: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepAlgoAPI_Cut>>;
        pub fn Shape(self: Pin<&mut BRepAlgoAPI_Cut>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepAlgoAPI_Cut>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepAlgoAPI_Cut) -> bool;
        pub fn Generated<'a>(
            self: Pin<&'a mut BRepAlgoAPI_Cut>,
            shape: &'a TopoDS_Shape,
        ) -> Result<&'a TopTools_ListOfShape>;
        pub fn SectionEdges(self: Pin<&mut BRepAlgoAPI_Cut>) -> Result<&TopTools_ListOfShape>;

        type BRepAlgoAPI_Common;
        #[cxx_name = "construct_unique"]
        pub fn BRepAlgoAPI_Common_new(
            shape_1: &TopoDS_Shape,
            shape_2: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepAlgoAPI_Common>>;
        pub fn Shape(self: Pin<&mut BRepAlgoAPI_Common>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepAlgoAPI_Common>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepAlgoAPI_Common) -> bool;
        pub fn SectionEdges(self: Pin<&mut BRepAlgoAPI_Common>) -> Result<&TopTools_ListOfShape>;

        type BRepAlgoAPI_Section;
        #[cxx_name = "construct_unique"]
        pub fn BRepAlgoAPI_Section_new(
            shape_1: &TopoDS_Shape,
            shape_2: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepAlgoAPI_Section>>;
        pub fn Shape(self: Pin<&mut BRepAlgoAPI_Section>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepAlgoAPI_Section>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepAlgoAPI_Section) -> bool;
        pub fn SectionEdges(self: Pin<&mut BRepAlgoAPI_Section>) -> Result<&TopTools_ListOfShape>;

        // One-shot booleans in OpenCASCADE's non-destructive ("safe processing") mode: the
        // arguments are never modified, and the operation stops early when `progress` asks it
        // to. The result is null when the operation fails. `warnings` gets the names of the
        // warnings the operation raised, separated by commas: a healthy boolean raises none.
        pub fn BRepAlgoAPI_fuse(
            a: &TopoDS_Shape,
            b: &TopoDS_Shape,
            progress: &Message_ProgressRange,
            warnings: &mut String,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
        /// Fuses `a` with every child of the compound `tools` in one operation.
        pub fn BRepAlgoAPI_fuse_children(
            a: &TopoDS_Shape,
            tools: &TopoDS_Shape,
            progress: &Message_ProgressRange,
            warnings: &mut String,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
        pub fn BRepAlgoAPI_cut(
            a: &TopoDS_Shape,
            b: &TopoDS_Shape,
            progress: &Message_ProgressRange,
            warnings: &mut String,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
        pub fn BRepAlgoAPI_common(
            a: &TopoDS_Shape,
            b: &TopoDS_Shape,
            progress: &Message_ProgressRange,
            warnings: &mut String,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
        pub fn BRepAlgoAPI_section(
            a: &TopoDS_Shape,
            b: &TopoDS_Shape,
            progress: &Message_ProgressRange,
            warnings: &mut String,
        ) -> Result<UniquePtr<TopoDS_Shape>>;
    }
}
