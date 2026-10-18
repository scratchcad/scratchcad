// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/iges_control.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type IFSelect_ReturnStatus = crate::if_select::IFSelect_ReturnStatus;
        type Message_ProgressRange = crate::message::Message_ProgressRange;

        type IGESControl_Reader;
        #[cxx_name = "construct_unique"]
        pub fn IGESControl_Reader_new() -> UniquePtr<IGESControl_Reader>;
        pub fn read_iges(
            reader: Pin<&mut IGESControl_Reader>,
            filename: String,
        ) -> Result<IFSelect_ReturnStatus>;
        pub fn TransferRoots(
            self: Pin<&mut IGESControl_Reader>,
            progress: &Message_ProgressRange,
        ) -> Result<i32>;
        pub fn one_shape_iges(reader: &IGESControl_Reader) -> Result<UniquePtr<TopoDS_Shape>>;

        type IGESControl_Writer;
        #[cxx_name = "construct_unique"]
        pub fn IGESControl_Writer_new() -> UniquePtr<IGESControl_Writer>;
        pub fn AddShape(
            self: Pin<&mut IGESControl_Writer>,
            shape: &TopoDS_Shape,
            progress: &Message_ProgressRange,
        ) -> Result<bool>;
        pub fn ComputeModel(self: Pin<&mut IGESControl_Writer>) -> Result<()>;
        pub fn write_iges(writer: Pin<&mut IGESControl_Writer>, filename: String) -> Result<bool>;
        /// The computed model as IGES text, or null if writing fails. (OpenCASCADE 7.8 can only
        /// read IGES from files.)
        pub fn write_iges_bytes(
            writer: Pin<&mut IGESControl_Writer>,
        ) -> Result<UniquePtr<CxxString>>;
    }
}
