//! Vectors, directions and planes, plus conversions to OpenCASCADE's `gp` types.

use crate::error::{invalid, Result};
use cxx::UniquePtr;
use glam::{DVec2, DVec3};
use scratchcad_occt_sys as ffi;
use std::fmt;

/// Lengths below this are treated as zero.
pub(crate) const EPSILON: f64 = 1e-9;

pub(crate) fn point(p: DVec3) -> UniquePtr<ffi::gp::gp_Pnt> {
    ffi::gp::new_point(p.x, p.y, p.z)
}

pub(crate) fn vector(v: DVec3) -> UniquePtr<ffi::gp::gp_Vec> {
    ffi::gp::new_vec(v.x, v.y, v.z)
}

pub(crate) fn direction(d: DVec3) -> Result<UniquePtr<ffi::gp::gp_Dir>> {
    if !d.is_finite() || d.length() < EPSILON {
        return Err(invalid(format!("direction must be a non-zero vector, got {}", fmt_vec(d))));
    }
    Ok(ffi::gp::gp_Dir_new(d.x, d.y, d.z)?)
}

/// Like [`point`], but rejects NaN and infinite coordinates, which OCCT would accept silently.
fn finite_point(p: DVec3, what: &str) -> Result<UniquePtr<ffi::gp::gp_Pnt>> {
    if !p.is_finite() {
        return Err(invalid(format!("{what} must be finite, got {}", fmt_vec(p))));
    }
    Ok(point(p))
}

pub(crate) fn axis1(origin: DVec3, dir: DVec3) -> Result<UniquePtr<ffi::gp::gp_Ax1>> {
    Ok(ffi::gp::gp_Ax1_new(&*finite_point(origin, "axis origin")?, &*direction(dir)?))
}

pub(crate) fn axis2(origin: DVec3, normal: DVec3) -> Result<UniquePtr<ffi::gp::gp_Ax2>> {
    Ok(ffi::gp::gp_Ax2_new(&*finite_point(origin, "axis origin")?, &*direction(normal)?))
}

pub(crate) fn from_pnt(p: &ffi::gp::gp_Pnt) -> DVec3 {
    DVec3::new(p.X(), p.Y(), p.Z())
}

pub(crate) fn from_vec(v: &ffi::gp::gp_Vec) -> DVec3 {
    DVec3::new(v.X(), v.Y(), v.Z())
}

pub(crate) fn fmt_vec(v: DVec3) -> String {
    format!("({}, {}, {})", v.x, v.y, v.z)
}

pub(crate) fn require_finite(value: f64, what: &str) -> Result<f64> {
    if value.is_finite() {
        Ok(value)
    } else {
        Err(invalid(format!("{what} must be a finite number, got {value}")))
    }
}

pub(crate) fn require_positive(value: f64, what: &str) -> Result<f64> {
    if value.is_finite() && value > 0.0 {
        Ok(value)
    } else {
        Err(invalid(format!("{what} must be positive, got {value}")))
    }
}

pub(crate) fn require_non_negative(value: f64, what: &str) -> Result<f64> {
    if value.is_finite() && value >= 0.0 {
        Ok(value)
    } else {
        Err(invalid(format!("{what} must not be negative, got {value}")))
    }
}

/// Parses an axis name such as `"X"`, `"+y"` or `"-Z"` into a unit vector.
pub fn parse_direction(name: &str) -> Result<DVec3> {
    let trimmed = name.trim();
    let (sign, axis) = match trimmed.strip_prefix('-') {
        Some(rest) => (-1.0, rest),
        None => (1.0, trimmed.strip_prefix('+').unwrap_or(trimmed)),
    };
    let unit = match axis.to_ascii_uppercase().as_str() {
        "X" => DVec3::X,
        "Y" => DVec3::Y,
        "Z" => DVec3::Z,
        _ => return Err(invalid(format!("unknown direction {name:?}, expected X, Y or Z"))),
    };
    Ok(unit * sign)
}

/// Normalizes `v`, failing on zero or non-finite vectors.
pub fn normalize(v: DVec3) -> Result<DVec3> {
    if !v.is_finite() || v.length() < EPSILON {
        return Err(invalid(format!("cannot normalize zero-length vector {}", fmt_vec(v))));
    }
    Ok(v.normalize())
}

/// A coordinate system for 2D sketches: an origin, an in-plane X direction and a normal.
///
/// The Y direction is `normal × x_dir`, so `(x_dir, y_dir, normal)` is right-handed.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Plane {
    origin: DVec3,
    x_dir: DVec3,
    normal: DVec3,
}

impl Plane {
    /// A plane through `origin` with the given normal and an automatically chosen X direction
    /// (the projection of the global X axis, or of the global Y axis when the normal is X).
    pub fn new(origin: DVec3, normal: DVec3) -> Result<Self> {
        let normal = normalize(normal)?;
        let reference = if normal.dot(DVec3::X).abs() > 0.999 { DVec3::Y } else { DVec3::X };
        let x_dir = (reference - normal * reference.dot(normal)).normalize();
        Self::check_origin(origin)?;
        Ok(Self { origin, x_dir, normal })
    }

    /// A plane with an explicit X direction, which must not be parallel to the normal. The X
    /// direction is projected into the plane.
    pub fn with_x_dir(origin: DVec3, normal: DVec3, x_dir: DVec3) -> Result<Self> {
        let normal = normalize(normal)?;
        let projected = x_dir - normal * x_dir.dot(normal);
        if projected.length() < 1e-6 * x_dir.length().max(1.0) {
            return Err(invalid(format!(
                "plane x direction {} is parallel to its normal {}",
                fmt_vec(x_dir),
                fmt_vec(normal)
            )));
        }
        Self::check_origin(origin)?;
        Ok(Self { origin, x_dir: projected.normalize(), normal })
    }

    fn check_origin(origin: DVec3) -> Result<()> {
        if origin.is_finite() {
            Ok(())
        } else {
            Err(invalid(format!("plane origin must be finite, got {}", fmt_vec(origin))))
        }
    }

    /// One of the named planes through the global origin, following CadQuery's naming: the
    /// first letter is the X direction and the second the Y direction.
    ///
    /// | name | x dir | normal |
    /// |------|-------|--------|
    /// | XY   | +X    | +Z     |
    /// | YZ   | +Y    | +X     |
    /// | ZX   | +Z    | +Y     |
    /// | XZ   | +X    | -Y     |
    /// | YX   | +Y    | -Z     |
    /// | ZY   | +Z    | -X     |
    pub fn named(name: &str) -> Result<Self> {
        let (x_dir, normal) = match name.trim().to_ascii_uppercase().as_str() {
            "XY" => (DVec3::X, DVec3::Z),
            "YZ" => (DVec3::Y, DVec3::X),
            "ZX" => (DVec3::Z, DVec3::Y),
            "XZ" => (DVec3::X, DVec3::NEG_Y),
            "YX" => (DVec3::Y, DVec3::NEG_Z),
            "ZY" => (DVec3::Z, DVec3::NEG_X),
            _ => {
                return Err(invalid(format!(
                    "unknown plane {name:?}, expected one of XY, YZ, ZX, XZ, YX, ZY"
                )))
            },
        };
        Ok(Self { origin: DVec3::ZERO, x_dir, normal })
    }

    /// The XY plane through the origin.
    pub fn xy() -> Self {
        Self { origin: DVec3::ZERO, x_dir: DVec3::X, normal: DVec3::Z }
    }

    pub fn origin(&self) -> DVec3 {
        self.origin
    }

    pub fn x_dir(&self) -> DVec3 {
        self.x_dir
    }

    pub fn y_dir(&self) -> DVec3 {
        self.normal.cross(self.x_dir)
    }

    pub fn normal(&self) -> DVec3 {
        self.normal
    }

    /// Converts plane coordinates to world coordinates.
    pub fn to_world(&self, local: DVec2) -> DVec3 {
        self.origin + self.x_dir * local.x + self.y_dir() * local.y
    }

    /// Projects a world point into plane coordinates.
    pub fn to_local(&self, world: DVec3) -> DVec2 {
        let relative = world - self.origin;
        DVec2::new(relative.dot(self.x_dir), relative.dot(self.y_dir()))
    }

    /// The same plane moved `distance` along its normal.
    pub fn offset(&self, distance: f64) -> Self {
        Self { origin: self.origin + self.normal * distance, ..*self }
    }

    /// The same plane moved by `delta`.
    pub fn translated(&self, delta: DVec3) -> Self {
        Self { origin: self.origin + delta, ..*self }
    }

    pub(crate) fn to_ax2(self) -> Result<UniquePtr<ffi::gp::gp_Ax2>> {
        Ok(ffi::gp::gp_Ax2_new_with_x_dir(
            &*finite_point(self.origin, "plane origin")?,
            &*direction(self.normal)?,
            &*direction(self.x_dir)?,
        )?)
    }
}

impl fmt::Display for Plane {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "Plane(origin: {}, x_dir: {}, normal: {})",
            fmt_vec(self.origin),
            fmt_vec(self.x_dir),
            fmt_vec(self.normal)
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn directions_parse_with_signs_and_case() {
        assert_eq!(parse_direction("X").unwrap(), DVec3::X);
        assert_eq!(parse_direction("+y").unwrap(), DVec3::Y);
        assert_eq!(parse_direction(" -Z ").unwrap(), DVec3::NEG_Z);
        assert!(parse_direction("W").is_err());
        assert!(parse_direction("").is_err());
    }

    #[test]
    fn normalize_rejects_zero_and_nan() {
        assert!(normalize(DVec3::new(0.0, 3.0, 4.0))
            .unwrap()
            .abs_diff_eq(DVec3::new(0.0, 0.6, 0.8), 1e-12));
        assert!(normalize(DVec3::ZERO).is_err());
        assert!(normalize(DVec3::new(f64::NAN, 0.0, 1.0)).is_err());
    }

    #[test]
    fn named_planes_are_right_handed() {
        for name in ["XY", "YZ", "ZX", "XZ", "YX", "ZY", "xy"] {
            let plane = Plane::named(name).unwrap();
            let x = plane.x_dir();
            let y = plane.y_dir();
            assert!((x.cross(y) - plane.normal()).length() < 1e-12, "{name}");
        }
        assert_eq!(Plane::named("XZ").unwrap().y_dir(), DVec3::Z);
        assert!(Plane::named("XX").is_err());
    }

    #[test]
    fn plane_new_picks_a_perpendicular_x_direction() {
        let plane = Plane::new(DVec3::ZERO, DVec3::Z).unwrap();
        assert_eq!(plane, Plane::xy());
        let plane = Plane::new(DVec3::ONE, DVec3::X * 2.0).unwrap();
        assert_eq!(plane.x_dir(), DVec3::Y);
        assert_eq!(plane.normal(), DVec3::X);
        let tilted = Plane::new(DVec3::ZERO, DVec3::new(1.0, 1.0, 1.0)).unwrap();
        assert!(tilted.x_dir().dot(tilted.normal()).abs() < 1e-12);
        assert!(Plane::new(DVec3::ZERO, DVec3::ZERO).is_err());
        assert!(Plane::new(DVec3::splat(f64::INFINITY), DVec3::Z).is_err());
    }

    #[test]
    fn plane_with_x_dir_projects_and_validates() {
        let plane = Plane::with_x_dir(DVec3::ZERO, DVec3::Z, DVec3::new(1.0, 0.0, 5.0)).unwrap();
        assert_eq!(plane.x_dir(), DVec3::X);
        assert!(Plane::with_x_dir(DVec3::ZERO, DVec3::Z, DVec3::Z).is_err());
        assert!(Plane::with_x_dir(DVec3::NAN, DVec3::Z, DVec3::X).is_err());
    }

    #[test]
    fn plane_coordinates_round_trip() {
        let plane = Plane::named("XZ").unwrap().translated(DVec3::new(1.0, 2.0, 3.0)).offset(2.0);
        assert_eq!(plane.origin(), DVec3::new(1.0, 0.0, 3.0));
        let world = plane.to_world(DVec2::new(4.0, 5.0));
        assert_eq!(world, DVec3::new(5.0, 0.0, 8.0));
        assert_eq!(plane.to_local(world), DVec2::new(4.0, 5.0));
        assert!(plane.to_string().starts_with("Plane(origin: (1, 0, 3)"));
    }

    #[test]
    fn number_validation() {
        assert_eq!(require_finite(1.5, "x").unwrap(), 1.5);
        assert!(require_finite(f64::NAN, "x").is_err());
        assert!(require_positive(0.0, "x").is_err());
        assert!(require_positive(-1.0, "x").is_err());
        assert_eq!(require_non_negative(0.0, "x").unwrap(), 0.0);
        assert!(require_non_negative(-0.1, "x").unwrap_err().to_string().contains("x must not"));
    }
}
