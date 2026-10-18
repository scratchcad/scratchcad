// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/gp.hxx");

        type gp;

        #[Self = "gp"]
        pub fn OX() -> &'static gp_Ax1;

        #[Self = "gp"]
        pub fn OY() -> &'static gp_Ax1;

        #[Self = "gp"]
        pub fn OZ() -> &'static gp_Ax1;

        #[Self = "gp"]
        pub fn DZ() -> &'static gp_Dir;

        // Point
        type gp_Pnt;
        #[cxx_name = "construct_unique"]
        pub fn new_point(x: f64, y: f64, z: f64) -> UniquePtr<gp_Pnt>;
        pub fn X(self: &gp_Pnt) -> f64;
        pub fn Y(self: &gp_Pnt) -> f64;
        pub fn Z(self: &gp_Pnt) -> f64;
        pub fn Distance(self: &gp_Pnt, other: &gp_Pnt) -> f64;
        pub fn Transform(self: Pin<&mut gp_Pnt>, transform: &gp_Trsf);

        type gp_Pnt2d;
        #[cxx_name = "construct_unique"]
        pub fn new_point_2d(x: f64, y: f64) -> UniquePtr<gp_Pnt2d>;
        pub fn X(self: &gp_Pnt2d) -> f64;
        pub fn Y(self: &gp_Pnt2d) -> f64;
        pub fn Distance(self: &gp_Pnt2d, other: &gp_Pnt2d) -> f64;

        // Vector
        type gp_Vec;
        #[cxx_name = "construct_unique"]
        pub fn new_vec(x: f64, y: f64, z: f64) -> UniquePtr<gp_Vec>;
        pub fn X(self: &gp_Vec) -> f64;
        pub fn Y(self: &gp_Vec) -> f64;
        pub fn Z(self: &gp_Vec) -> f64;
        pub fn Magnitude(self: &gp_Vec) -> f64;

        // Line
        type gp_Lin;
        #[cxx_name = "construct_unique"]
        pub fn gp_Lin_new(point: &gp_Pnt, dir: &gp_Dir) -> UniquePtr<gp_Lin>;

        // Circle
        type gp_Circ;
        /// Fails with `Standard_ConstructionError` when `radius` is negative.
        #[cxx_name = "construct_unique"]
        pub fn gp_Circ_new(axis: &gp_Ax2, radius: f64) -> Result<UniquePtr<gp_Circ>>;
        pub fn Radius(self: &gp_Circ) -> f64;

        // Axes
        type gp_Ax1;
        #[cxx_name = "construct_unique"]
        pub fn gp_Ax1_new(origin: &gp_Pnt, main_dir: &gp_Dir) -> UniquePtr<gp_Ax1>;

        type gp_Ax2;
        #[cxx_name = "construct_unique"]
        pub fn gp_Ax2_new(origin: &gp_Pnt, main_dir: &gp_Dir) -> UniquePtr<gp_Ax2>;
        /// Fails with `Standard_ConstructionError` when `main_dir` and `x_dir` are parallel.
        #[cxx_name = "construct_unique"]
        pub fn gp_Ax2_new_with_x_dir(
            origin: &gp_Pnt,
            main_dir: &gp_Dir,
            x_dir: &gp_Dir,
        ) -> Result<UniquePtr<gp_Ax2>>;
        pub fn gp_Ax2_x_direction(axis: &gp_Ax2) -> UniquePtr<gp_Dir>;
        pub fn gp_Ax2_y_direction(axis: &gp_Ax2) -> UniquePtr<gp_Dir>;

        type gp_Ax3;
        #[cxx_name = "construct_unique"]
        pub fn gp_Ax3_from_gp_Ax2(axis: &gp_Ax2) -> UniquePtr<gp_Ax3>;

        type gp_Dir2d;
        /// Fails with `Standard_ConstructionError` for a zero-length input vector.
        #[cxx_name = "construct_unique"]
        pub fn gp_Dir2d_new(x: f64, y: f64) -> Result<UniquePtr<gp_Dir2d>>;
        pub fn X(self: &gp_Dir2d) -> f64;
        pub fn Y(self: &gp_Dir2d) -> f64;

        type gp_Ax2d;
        #[cxx_name = "construct_unique"]
        pub fn gp_Ax2d_new(point: &gp_Pnt2d, dir: &gp_Dir2d) -> UniquePtr<gp_Ax2d>;

        // Direction
        type gp_Dir;
        /// Fails with `Standard_ConstructionError` for a zero-length input vector.
        #[cxx_name = "construct_unique"]
        pub fn gp_Dir_new(x: f64, y: f64, z: f64) -> Result<UniquePtr<gp_Dir>>;
        pub fn Transform(self: Pin<&mut gp_Dir>, transform: &gp_Trsf);
        pub fn X(self: &gp_Dir) -> f64;
        pub fn Y(self: &gp_Dir) -> f64;
        pub fn Z(self: &gp_Dir) -> f64;

        // Transform
        type gp_Trsf;
        #[cxx_name = "construct_unique"]
        pub fn new_transform() -> UniquePtr<gp_Trsf>;
        #[rust_name = "set_mirror_axis"]
        pub fn SetMirror(self: Pin<&mut gp_Trsf>, axis: &gp_Ax1);
        #[rust_name = "set_mirror_plane"]
        pub fn SetMirror(self: Pin<&mut gp_Trsf>, plane: &gp_Ax2);
        #[rust_name = "set_mirror_point"]
        pub fn SetMirror(self: Pin<&mut gp_Trsf>, point: &gp_Pnt);
        pub fn SetRotation(self: Pin<&mut gp_Trsf>, axis: &gp_Ax1, angle: f64);
        /// OCCT does not validate `scale` in release builds; a zero factor produces a
        /// degenerate transform, so callers should reject it.
        pub fn SetScale(self: Pin<&mut gp_Trsf>, point: &gp_Pnt, scale: f64);
        pub fn SetTranslation(self: Pin<&mut gp_Trsf>, point1: &gp_Pnt, point2: &gp_Pnt);
        /// Fails with `Standard_OutOfRange` unless `1 <= row <= 3` and `1 <= col <= 4`.
        pub fn Value(self: &gp_Trsf, the_row: i32, the_col: i32) -> Result<f64>;
        pub fn ScaleFactor(self: &gp_Trsf) -> f64;
        pub fn Multiply(self: Pin<&mut gp_Trsf>, other: &gp_Trsf);

        #[cxx_name = "SetTranslationPart"]
        pub fn set_translation_vec(self: Pin<&mut gp_Trsf>, translation: &gp_Vec);

        type gp_GTrsf;
        #[cxx_name = "construct_unique"]
        pub fn new_gp_GTrsf() -> UniquePtr<gp_GTrsf>;
        /// Fails with `Standard_OutOfRange` unless `1 <= row <= 3` and `1 <= col <= 4`.
        pub fn SetValue(
            self: Pin<&mut gp_GTrsf>,
            the_row: i32,
            the_col: i32,
            the_value: f64,
        ) -> Result<()>;
        /// Fails with `Standard_OutOfRange` unless `1 <= row <= 3` and `1 <= col <= 4`.
        pub fn Value(self: &gp_GTrsf, the_row: i32, the_col: i32) -> Result<f64>;
    }
}

unsafe impl Send for inner::gp_Pnt {}
unsafe impl Send for inner::gp_Vec {}
unsafe impl Send for inner::gp_Dir {}
unsafe impl Send for inner::gp_Trsf {}
