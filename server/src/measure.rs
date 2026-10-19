//! What `POST /v1/scripts/validate` reports about a shape: its topology,
//! validity, size and mass properties, and warnings about anything that will
//! cause trouble later.

use scratchcad_occt_rhai::{DVec3, Error, MassProperties, Shape};
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
    /// Enclosed volume; 0 without solids. Left out with the mass properties.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub volume: Option<f64>,
    /// Total area of the faces. Left out with the mass properties.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub area: Option<f64>,
    /// Center of mass (of the volume, else the area, else the edges). Left out with the mass
    /// properties.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub center: Option<[f64; 3]>,
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

/// The mass properties to report, and warnings about them: approximate ones are reported with a
/// warning, and ones OpenCASCADE could not measure are left out with one.
fn checked(measured: Result<MassProperties, Error>) -> (Option<MassProperties>, Vec<String>) {
    match measured {
        Ok(m) if m.exact => (Some(m), vec![]),
        Ok(m) => (
            Some(m),
            vec![
                "the volume, area and center are approximate (to about a percent): the shape's \
                  B-spline geometry could not be split into Bézier patches to measure it exactly"
                    .into(),
            ],
        ),
        Err(e) => (
            None,
            vec![format!(
                "the volume, area and center are left out: OpenCASCADE could not measure them \
                 ({e})"
            )],
        ),
    }
}

/// Measures the shape and lists what is likely to go wrong with it. Without `mass`, the
/// volume, area and center, which take the longest to measure, are left out; they are also left
/// out, with a warning, when OpenCASCADE can't measure them, as the rest still describes the shape.
pub fn summarize(shape: &Shape, mass: bool) -> Result<(ShapeSummary, Vec<String>), ApiError> {
    let bbox = bounding_box(shape)?;
    let valid = shape.is_valid();
    let (mass, notes) = if mass {
        checked(shape.mass_properties())
    } else {
        (None, vec![])
    };
    let summary = ShapeSummary {
        kind: shape.shape_type().name().into(),
        solids: shape.solids().len(),
        faces: shape.faces().len(),
        edges: shape.edges().len(),
        vertices: shape.vertices().len(),
        valid,
        bounding_box: BoundingBox {
            min: array(bbox.min),
            max: array(bbox.max),
            size: array(bbox.size()),
        },
        volume: mass.map(|m| m.volume),
        area: mass.map(|m| m.area),
        center: mass.map(|m| array(m.center)),
    };
    let mut warnings = warnings(&summary);
    warnings.extend(notes);
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
        summarize(&shape, true).unwrap()
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
        assert!((s.volume.unwrap() - 6000.0).abs() < 1e-6);
        assert!((s.area.unwrap() - 2200.0).abs() < 1e-6);
        assert!((s.center.unwrap()[2] - 15.0).abs() < 1e-9);
        assert!(warnings.is_empty());

        let shape = scratchcad_occt_rhai::eval_shape("box(10, 20, 30)").unwrap();
        let (quick, _) = summarize(&shape, false).unwrap();
        assert_eq!((quick.volume, quick.area, quick.center), (None, None, None));
        assert_eq!(quick.bounding_box, s.bounding_box);
    }

    #[test]
    fn warns_about_shapes_without_solids() {
        let (s, warnings) = summary_of("box(1, 1, 1).face(\">Z\")");
        assert_eq!(
            (s.kind.as_str(), s.solids, s.volume),
            ("face", 0, Some(0.0))
        );
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
    fn approximate_and_missing_mass_properties_are_warnings() {
        let m = MassProperties {
            volume: 1.0,
            area: 6.0,
            center: DVec3::ZERO,
            exact: true,
        };
        assert_eq!(checked(Ok(m)), (Some(m), vec![]));
        let rough = MassProperties { exact: false, ..m };
        let (kept, notes) = checked(Ok(rough));
        assert_eq!(kept, Some(rough));
        assert!(notes[0].contains("approximate"));
        let (kept, notes) = checked(Err(Error::OperationFailed("split")));
        assert_eq!(kept, None);
        assert!(notes[0].contains("left out") && notes[0].contains("split"));
    }

    #[test]
    fn measuring_errors() {
        let e = measure_error(Error::InvalidArgument("x".into()));
        assert!(matches!(e, ApiError::Unprocessable(m) if m.contains("could not measure")));
    }
}
