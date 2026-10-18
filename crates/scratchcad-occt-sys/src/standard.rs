// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/standard.hxx");

        type Handle_Standard_Type;
        pub fn type_name(handle: &Handle_Standard_Type) -> Result<String>;
        pub fn IsNull(self: &Handle_Standard_Type) -> bool;
    }
}
