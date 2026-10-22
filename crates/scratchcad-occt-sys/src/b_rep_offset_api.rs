// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    #[derive(Debug)]
    #[repr(u32)]
    pub enum BRepOffset_Mode {
        BRepOffset_Skin,
        BRepOffset_Pipe,
        BRepOffset_RectoVerso,
    }

    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/b_rep_offset_api.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type TopoDS_Face = crate::topo_ds::TopoDS_Face;
        type TopoDS_Wire = crate::topo_ds::TopoDS_Wire;
        type GeomAbs_JoinType = crate::geom_abs::GeomAbs_JoinType;
        type TopTools_ListOfShape = crate::top_tools::TopTools_ListOfShape;
        type Message_ProgressRange = crate::message::Message_ProgressRange;
        type Handle_Law_Function = crate::law::Handle_Law_Function;

        type BRepOffset_Mode;

        type BRepOffsetAPI_MakeOffset;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_MakeOffset_face_new(
            face: &TopoDS_Face,
            join: GeomAbs_JoinType,
        ) -> Result<UniquePtr<BRepOffsetAPI_MakeOffset>>;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_MakeOffset_wire_new(
            wire: &TopoDS_Wire,
            join: GeomAbs_JoinType,
        ) -> Result<UniquePtr<BRepOffsetAPI_MakeOffset>>;
        pub fn Perform(
            self: Pin<&mut BRepOffsetAPI_MakeOffset>,
            offset: f64,
            alt: f64,
        ) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepOffsetAPI_MakeOffset>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepOffsetAPI_MakeOffset>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepOffsetAPI_MakeOffset) -> bool;

        type BRepOffsetAPI_MakeThickSolid;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_MakeThickSolid_new() -> UniquePtr<BRepOffsetAPI_MakeThickSolid>;
        #[allow(clippy::too_many_arguments)]
        pub fn MakeThickSolidByJoin(
            self: Pin<&mut BRepOffsetAPI_MakeThickSolid>,
            shape: &TopoDS_Shape,
            closing_faces: &TopTools_ListOfShape,
            offset: f64,
            tolerance: f64,
            offset_mode: BRepOffset_Mode,
            intersection: bool,
            self_intersection: bool,
            join_type: GeomAbs_JoinType,
            remove_intersecting_edges: bool,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn Shape(self: Pin<&mut BRepOffsetAPI_MakeThickSolid>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepOffsetAPI_MakeThickSolid>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepOffsetAPI_MakeThickSolid) -> bool;

        type BRepOffsetAPI_MakePipe;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_MakePipe_new(
            spine: &TopoDS_Wire,
            profile: &TopoDS_Shape,
        ) -> Result<UniquePtr<BRepOffsetAPI_MakePipe>>;
        pub fn Shape(self: Pin<&mut BRepOffsetAPI_MakePipe>) -> Result<&TopoDS_Shape>;
        pub fn IsDone(self: &BRepOffsetAPI_MakePipe) -> bool;

        type BRepOffsetAPI_MakePipeShell;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_MakePipeShell_new(
            spine: &TopoDS_Wire,
        ) -> Result<UniquePtr<BRepOffsetAPI_MakePipeShell>>;
        pub fn SetMode(self: Pin<&mut BRepOffsetAPI_MakePipeShell>, is_frenet: bool);
        pub fn BRepOffsetAPI_MakePipeShell_SetRightCorners(
            make: Pin<&mut BRepOffsetAPI_MakePipeShell>,
        );
        pub fn Add(
            self: Pin<&mut BRepOffsetAPI_MakePipeShell>,
            profile: &TopoDS_Shape,
            with_contact: bool,
            with_correction: bool,
        ) -> Result<()>;
        pub fn SetLaw(
            self: Pin<&mut BRepOffsetAPI_MakePipeShell>,
            profile: &TopoDS_Shape,
            law: &Handle_Law_Function,
            with_contact: bool,
            with_correction: bool,
        ) -> Result<()>;
        pub fn Build(
            self: Pin<&mut BRepOffsetAPI_MakePipeShell>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn MakeSolid(self: Pin<&mut BRepOffsetAPI_MakePipeShell>) -> Result<bool>;
        pub fn IsDone(self: &BRepOffsetAPI_MakePipeShell) -> bool;
        pub fn Shape(self: Pin<&mut BRepOffsetAPI_MakePipeShell>) -> Result<&TopoDS_Shape>;

        type BRepOffsetAPI_ThruSections;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_ThruSections_new(
            is_solid: bool,
        ) -> UniquePtr<BRepOffsetAPI_ThruSections>;
        pub fn AddWire(
            self: Pin<&mut BRepOffsetAPI_ThruSections>,
            wire: &TopoDS_Wire,
        ) -> Result<()>;
        #[cxx_name = "construct_unique"]
        pub fn BRepOffsetAPI_ThruSections_new_ruled(
            is_solid: bool,
            ruled: bool,
        ) -> UniquePtr<BRepOffsetAPI_ThruSections>;
        pub fn CheckCompatibility(self: Pin<&mut BRepOffsetAPI_ThruSections>, check: bool);
        pub fn Shape(self: Pin<&mut BRepOffsetAPI_ThruSections>) -> Result<&TopoDS_Shape>;
        pub fn Build(
            self: Pin<&mut BRepOffsetAPI_ThruSections>,
            progress: &Message_ProgressRange,
        ) -> Result<()>;
        pub fn IsDone(self: &BRepOffsetAPI_ThruSections) -> bool;
    }
}
