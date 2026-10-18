// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/step_control.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;
        type IFSelect_ReturnStatus = crate::if_select::IFSelect_ReturnStatus;
        type Message_ProgressRange = crate::message::Message_ProgressRange;

        type STEPControl_Reader;
        #[cxx_name = "construct_unique"]
        pub fn STEPControl_Reader_new() -> UniquePtr<STEPControl_Reader>;
        pub fn read_step(
            reader: Pin<&mut STEPControl_Reader>,
            filename: String,
        ) -> Result<IFSelect_ReturnStatus>;
        /// Reads a STEP model from memory.
        pub fn read_step_bytes(
            reader: Pin<&mut STEPControl_Reader>,
            bytes: &[u8],
        ) -> Result<IFSelect_ReturnStatus>;
        pub fn TransferRoots(
            self: Pin<&mut STEPControl_Reader>,
            progress: &Message_ProgressRange,
        ) -> Result<i32>;
        pub fn one_shape_step(reader: &STEPControl_Reader) -> Result<UniquePtr<TopoDS_Shape>>;

        type STEPControl_Writer;
        #[cxx_name = "construct_unique"]
        pub fn STEPControl_Writer_new() -> UniquePtr<STEPControl_Writer>;
        // TODO: Expose the STEP transfer mode (currently always `STEPControl_AsIs`).
        pub fn transfer_shape(
            writer: Pin<&mut STEPControl_Writer>,
            shape: &TopoDS_Shape,
        ) -> Result<IFSelect_ReturnStatus>;
        /// Like `transfer_shape`, stopping early when `progress` asks it to.
        pub fn transfer_shape_with_progress(
            writer: Pin<&mut STEPControl_Writer>,
            shape: &TopoDS_Shape,
            progress: &Message_ProgressRange,
        ) -> Result<IFSelect_ReturnStatus>;
        pub fn write_step(
            writer: Pin<&mut STEPControl_Writer>,
            filename: String,
        ) -> Result<IFSelect_ReturnStatus>;
        /// The transferred model as STEP text, or null if writing fails.
        pub fn write_step_bytes(
            writer: Pin<&mut STEPControl_Writer>,
        ) -> Result<UniquePtr<CxxString>>;
    }
}
