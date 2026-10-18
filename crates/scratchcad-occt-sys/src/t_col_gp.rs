// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/t_col_gp.hxx");

        type gp_Pnt = crate::gp::gp_Pnt;
        type gp_Dir = crate::gp::gp_Dir;
        type gp_Pnt2d = crate::gp::gp_Pnt2d;

        // Handles
        type Handle_TColgp_HArray1OfPnt;

        pub fn new_HandleTColgpHArray1OfPnt_from_TColgpHArray1OfPnt(
            array: UniquePtr<TColgp_HArray1OfPnt>,
        ) -> UniquePtr<Handle_TColgp_HArray1OfPnt>;
        // End Handles

        type TColgp_Array1OfDir;
        #[cxx_name = "construct_unique"]
        pub fn TColgp_Array1OfDir_new(
            lower_bound: i32,
            upper_bound: i32,
        ) -> Result<UniquePtr<TColgp_Array1OfDir>>;
        pub fn Length(self: &TColgp_Array1OfDir) -> i32;
        pub fn TColgp_Array1OfDir_Value(
            array: &TColgp_Array1OfDir,
            index: i32,
        ) -> Result<UniquePtr<gp_Dir>>;

        type TColgp_Array1OfPnt2d;
        #[cxx_name = "construct_unique"]
        pub fn TColgp_Array1OfPnt2d_new(
            lower_bound: i32,
            upper_bound: i32,
        ) -> Result<UniquePtr<TColgp_Array1OfPnt2d>>;
        pub fn Length(self: &TColgp_Array1OfPnt2d) -> i32;
        pub fn TColgp_Array1OfPnt2d_Value(
            array: &TColgp_Array1OfPnt2d,
            index: i32,
        ) -> Result<UniquePtr<gp_Pnt2d>>;
        pub fn SetValue(
            self: Pin<&mut TColgp_Array1OfPnt2d>,
            index: i32,
            item: &gp_Pnt2d,
        ) -> Result<()>;

        type TColgp_Array2OfPnt;
        #[cxx_name = "construct_unique"]
        pub fn TColgp_Array2OfPnt_new(
            row_lower: i32,
            row_upper: i32,
            column_lower: i32,
            column_upper: i32,
        ) -> Result<UniquePtr<TColgp_Array2OfPnt>>;
        pub fn SetValue(
            self: Pin<&mut TColgp_Array2OfPnt>,
            row: i32,
            column: i32,
            item: &gp_Pnt,
        ) -> Result<()>;

        type TColgp_HArray1OfPnt;
        #[cxx_name = "construct_unique"]
        pub fn TColgp_HArray1OfPnt_new(
            lower_bound: i32,
            upper_bound: i32,
        ) -> Result<UniquePtr<TColgp_HArray1OfPnt>>;
        pub fn Length(self: &TColgp_HArray1OfPnt) -> i32;
        pub fn TColgp_HArray1OfPnt_Value(
            array: &TColgp_HArray1OfPnt,
            index: i32,
        ) -> Result<UniquePtr<gp_Pnt>>;
        pub fn SetValue(
            self: Pin<&mut TColgp_HArray1OfPnt>,
            index: i32,
            item: &gp_Pnt,
        ) -> Result<()>;
    }
}
