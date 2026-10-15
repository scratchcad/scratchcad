//! What `POST /v1/scripts/validate` reports about a shape: its topology,
//! validity, size and mass properties, and warnings about anything that will
//! cause trouble later.

use scratchcad_occt_rhai::{DVec3, Error, Shape};
use serde::{Deserialize, Serialize};

use crate::error::ApiError;

#[derive(Serialize, Deserialize, Debug, Clone, PartialEq)]
pub struct BoundingBox {
    pub min: [f64; 3],
    pub max: [f64; 3],
    pub size: [f64; 3],
}

#[derive(Serialize, Deserialize, Debug, Clone, PartialEq)]
pub struct ShapeSummary {
    /// `vertex`, `edge`, `wire`, `face`, `shell`, `solid`, `compsolid` or `compound`
    #[serde(rename = "type")]
    pub kind: String,
    pub solids: usize,
    pub faces: usize,
    pub edges: usize,
    pub vertices: usize,
    /// Whether OpenCASCADE's checker finds the shape valid
    pub valid: bool,
    pub bounding_box: BoundingBox,
    /// Enclosed volume; 0 without solids
    pub volume: f64,
    /// Total area of the faces
    pub area: f64,
    /// Center of mass (of the volume, else the area, else the edges)
    pub center: [f64; 3],
}

/// A shape OpenCASCADE can't measure
pub(crate) fn measure_error(e: Error) -> ApiError {
    ApiError::Unprocessable(format!("could not measure the shape: {e}"))
}

/// The tight bounding box of a shape that has at least one vertex
pub fn bounding_box(shape: &Shape) -> Result<scratchcad_occt_rhai::BoundingBox, ApiError> {
    shape.bounding_box().map_err(measure_error)
}

fn array(v: DVec3) -> [f64; 3] {
    v.to_array()
}

/// Measures the shape and lists what is likely to go wrong with it
pub fn summarize(shape: &Shape) -> Result<(ShapeSummary, Vec<String>), ApiError> {
    let bbox = bounding_box(shape)?;
    let summary = ShapeSummary {
        kind: shape.shape_type().name().into(),
        solids: shape.solids().len(),
        faces: shape.faces().len(),
        edges: shape.edges().len(),
        vertices: shape.vertices().len(),
        valid: shape.is_valid(),
        bounding_box: BoundingBox {
            min: array(bbox.min),
            max: array(bbox.max),
            size: array(bbox.size()),
        },
        volume: shape.volume().map_err(measure_error)?,
        area: shape.area().map_err(measure_error)?,
        center: array(shape.center().map_err(measure_error)?),
    };
    let warnings = warnings(&summary);
    Ok((summary, warnings))
}

fn warnings(s: &ShapeSummary) -> Vec<String> {
    let mut out = vec![];
    if !s.valid {
        out.push(
            "OpenCASCADE's checker reports the shape as invalid (for example self-intersecting \
             or with gaps between faces): booleans, fillets and exports may fail or give wrong \
             results. Look for zero-thickness walls or faces that only touch, or try .clean()"
                .into(),
        );
    }
    if s.solids == 0 {
        let what = if s.faces > 0 {
            "faces but no enclosed volume"
        } else {
            "no faces: it is only lines and points"
        };
        out.push(format!(
            "the shape has no solids ({} with {what}): its volume is 0, sections are not \
             filled, and mesh exports are not watertight. Extrude, revolve or loft profiles \
             into solids",
            s.kind
        ));
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    fn summary_of(script: &str) -> (ShapeSummary, Vec<String>) {
        let shape = scratchcad_occt_rhai::eval_shape(script).unwrap();
        summarize(&shape).unwrap()
    }

    #[test]
    fn summarizes_a_box() {
        let (s, warnings) = summary_of("box(10, 20, 30)");
        assert_eq!(
            (s.kind.as_str(), s.solids, s.faces, s.edges, s.vertices),
            ("solid", 1, 6, 12, 8)
        );
        assert!(s.valid);
        assert_eq!(s.bounding_box.size, [10.0, 20.0, 30.0]);
        assert!(s.bounding_box.min.iter().all(|v| v.abs() < 1e-6));
        assert!((s.volume - 6000.0).abs() < 1e-6);
        assert!((s.area - 2200.0).abs() < 1e-6);
        assert!((s.center[2] - 15.0).abs() < 1e-9);
        assert!(warnings.is_empty());
    }

    #[test]
    fn warns_about_shapes_without_solids() {
        let (s, warnings) = summary_of("box(1, 1, 1).face(\">Z\")");
        assert_eq!((s.kind.as_str(), s.solids, s.volume), ("face", 0, 0.0));
        assert_eq!(warnings.len(), 1);
        assert!(warnings[0].contains("face with faces but no enclosed volume"));

        let (s, warnings) = summary_of("circle(5)");
        assert_eq!((s.kind.as_str(), s.faces), ("wire", 0));
        assert!(warnings[0].contains("only lines and points"));
    }

    #[test]
    fn warns_about_invalid_shapes() {
        let mut s = summary_of("cube(1)").0;
        s.valid = false;
        let w = warnings(&s);
        assert_eq!(w.len(), 1);
        assert!(w[0].contains("invalid"));
    }

    #[test]
    fn measuring_errors() {
        let e = measure_error(Error::InvalidArgument("x".into()));
        assert!(matches!(e, ApiError::Unprocessable(m) if m.contains("could not measure")));
    }
}
