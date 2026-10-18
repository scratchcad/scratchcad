// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/stl_api.hxx");

        type TopoDS_Shape = crate::topo_ds::TopoDS_Shape;

        type StlAPI_Writer;
        #[cxx_name = "construct_unique"]
        pub fn StlAPI_Writer_new() -> UniquePtr<StlAPI_Writer>;
        pub fn write_stl(
            writer: Pin<&mut StlAPI_Writer>,
            shape: &TopoDS_Shape,
            filename: String,
        ) -> Result<bool>;
    }
}
