// Modified by Joaquim Dalton-Pereira, 2026-10-13. Based on opencascade-rs
// (https://github.com/bschwind/opencascade-rs); later changes are in the git history.

pub use inner::*;

#[cxx::bridge]
mod inner {
    #[repr(u32)]
    #[derive(Debug)]
    pub enum TopAbs_ShapeEnum {
        TopAbs_COMPOUND,
        TopAbs_COMPSOLID,
        TopAbs_SOLID,
        TopAbs_SHELL,
        TopAbs_FACE,
        TopAbs_WIRE,
        TopAbs_EDGE,
        TopAbs_VERTEX,
        TopAbs_SHAPE,
    }

    #[repr(u32)]
    #[derive(Debug)]
    pub enum TopAbs_Orientation {
        TopAbs_FORWARD,
        TopAbs_REVERSED,
        TopAbs_INTERNAL,
        TopAbs_EXTERNAL,
    }

    /// Where a point lies relative to a shape.
    #[repr(u32)]
    #[derive(Debug)]
    pub enum TopAbs_State {
        TopAbs_IN,
        TopAbs_OUT,
        TopAbs_ON,
        TopAbs_UNKNOWN,
    }

    unsafe extern "C++" {
        include!("scratchcad-occt-sys/include/top_abs.hxx");

        type TopAbs_Orientation;
        type TopAbs_ShapeEnum;
        type TopAbs_State;
    }
}
