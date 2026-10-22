//! Meshing shapes for renders and mesh exports, and finding the edges a
//! render draws.

use std::collections::HashMap;

use scratchcad_occt_rhai::{DVec3, Error, Mesh, MeshOptions, Shape};

use crate::error::ApiError;

/// Angular tolerance for every mesh, in degrees: small holes and fillets get
/// at least 24 segments per full turn, whatever the linear tolerance.
pub const ANGULAR_TOLERANCE: f64 = 15.0;

/// Default linear tolerance of a mesh export, as a fraction of the shape's
/// bounding-box diagonal
pub const DEFAULT_RELATIVE_TOLERANCE: f64 = 1e-3;
/// The finest linear tolerance any mesh is made with, as a fraction of the
/// bounding-box diagonal
pub const MIN_RELATIVE_TOLERANCE: f64 = 1e-5;
/// The finest a render meshes, as a fraction of the diagonal: renders are
/// meshed to about half a pixel, but zooming in shouldn't mesh the whole part
/// at a tolerance only the visible piece needs
const MIN_RENDER_RELATIVE_TOLERANCE: f64 = 1e-4;

/// Two faces meeting at more than this angle (in degrees) draw an edge;
/// tangent faces, like a fillet and the faces it rounds, don't
pub const SHARP_ANGLE: f64 = 30.0;

/// Samples along a curved edge drawn on its own (a shape with no faces)
const CURVE_SAMPLES: usize = 64;

/// The length that linear tolerances are relative to.  Shapes that are a
/// single point have no size, so they get 1.
pub fn scale(diagonal: f64) -> f64 {
    if diagonal > 0.0 { diagonal } else { 1.0 }
}

/// The tolerance a mesh export uses: the requested one or the default. A
/// request finer than the floor is an error, rather than meshed coarser
/// than asked
pub fn export_tolerance(requested: Option<f64>, diagonal: f64) -> Result<f64, ApiError> {
    let scale = scale(diagonal);
    let floor = scale * MIN_RELATIVE_TOLERANCE;
    match requested {
        None => Ok(scale * DEFAULT_RELATIVE_TOLERANCE),
        Some(t) if t < floor => Err(ApiError::BadRequest(format!(
            "tolerance {t} is finer than a mesh can be made, 1e-5 of the shape's \
             bounding-box diagonal ({diagonal:.6}): ask for {floor:.3e} or more, or export \
             STEP, IGES or BREP, which keep the exact surfaces"
        ))),
        Some(t) => Ok(t),
    }
}

/// The tolerance a render meshes with: half the size of a pixel, but no
/// finer than 1e-4 of the diagonal
pub fn render_tolerance(pixel: f64, diagonal: f64) -> f64 {
    (pixel / 2.0).max(scale(diagonal) * MIN_RENDER_RELATIVE_TOLERANCE)
}

fn mesh_error(e: Error) -> ApiError {
    ApiError::MeshFailed(format!("meshing failed: {e}"))
}

/// Triangulates every face, failing if the mesh has more than `max_triangles`
pub fn mesh(shape: &Shape, tolerance: f64, max_triangles: usize) -> Result<Mesh, ApiError> {
    let options = MeshOptions::new(tolerance).angular_tolerance(ANGULAR_TOLERANCE);
    let mesh = shape.mesh_with(&options).map_err(mesh_error)?;
    let triangles = mesh.triangle_count();
    if triangles > max_triangles {
        return Err(ApiError::LimitExceeded(format!(
            "the mesh has {triangles} triangles at tolerance {tolerance:.3e}; the limit is \
             {max_triangles} (use a coarser tolerance)"
        )));
    }
    Ok(mesh)
}

/// The facet normal of triangle `t`, or zero for a degenerate one
fn facet_normal(mesh: &Mesh, t: usize) -> DVec3 {
    let [a, b, c] = [0, 1, 2].map(|i| mesh.vertices[mesh.indices[3 * t + i]]);
    (b - a).cross(c - a).normalize_or_zero()
}

/// The triangles using one edge of a welded mesh
#[derive(Default)]
struct EdgeUse {
    count: usize,
    first: usize,
    second: usize,
}

/// Line segments along the shape's sharp edges, from its welded mesh.
///
/// Welding merges the vertices faces share, so a mesh edge used by triangles
/// of two different B-rep faces (`face_triangles`) lies on a B-rep edge.  It
/// is drawn where the faces meet at more than [`SHARP_ANGLE`]: corners and
/// chamfers, but not tangent joins like a fillet's, nor faces that continue
/// each other.  Edges used by one triangle (the border of an open face) and
/// by more than two (non-manifold) are drawn too.
pub fn sharp_edges(welded: &Mesh) -> Vec<[DVec3; 2]> {
    let faces = welded.triangle_faces();
    let mut uses: HashMap<(usize, usize), EdgeUse> = HashMap::new();
    for t in 0..welded.triangle_count() {
        let tri = &welded.indices[3 * t..3 * t + 3];
        for (a, b) in [(tri[0], tri[1]), (tri[1], tri[2]), (tri[2], tri[0])] {
            let edge = uses.entry((a.min(b), a.max(b))).or_default();
            match edge.count {
                0 => edge.first = t,
                1 => edge.second = t,
                _ => {}
            }
            edge.count += 1;
        }
    }
    let cos_sharp = SHARP_ANGLE.to_radians().cos();
    let mut out: Vec<_> = uses
        .into_iter()
        .filter(|(_, e)| match e.count {
            2 => {
                faces[e.first] != faces[e.second] && {
                    let n1 = facet_normal(welded, e.first);
                    let n2 = facet_normal(welded, e.second);
                    n1 != DVec3::ZERO && n2 != DVec3::ZERO && n1.dot(n2) < cos_sharp
                }
            }
            _ => true,
        })
        .map(|((a, b), _)| [welded.vertices[a], welded.vertices[b]])
        .collect();
    // Hash order varies between runs; keep renders reproducible.
    out.sort_by(|p, q| {
        let key = |s: &[DVec3; 2]| [s[0].x, s[0].y, s[0].z, s[1].x, s[1].y, s[1].z];
        key(p)
            .iter()
            .zip(key(q).iter())
            .map(|(a, b)| a.total_cmp(b))
            .find(|o| o.is_ne())
            .unwrap_or(std::cmp::Ordering::Equal)
    });
    out
}

/// Line segments along every edge of a shape, sampled from the B-rep.  For
/// shapes without faces (wires, edges), which have no mesh to draw.
pub fn sampled_edges(shape: &Shape) -> Vec<[DVec3; 2]> {
    let mut out = vec![];
    for edge in shape.edges().iter() {
        let samples = match edge.geom_type() {
            Ok("line") => 1,
            _ => CURVE_SAMPLES,
        };
        let points: Result<Vec<DVec3>, _> = (0..=samples)
            .map(|i| edge.point_at(i as f64 / samples as f64))
            .collect();
        // Degenerate edges have no curve to sample; there is nothing to draw.
        if let Ok(points) = points {
            out.extend(points.windows(2).map(|w| [w[0], w[1]]));
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use scratchcad_occt_rhai::eval_shape;

    #[test]
    fn export_tolerances() {
        assert_eq!(export_tolerance(None, 100.0).unwrap(), 0.1);
        assert_eq!(export_tolerance(Some(0.5), 100.0).unwrap(), 0.5);
        assert_eq!(export_tolerance(Some(1e-3), 100.0).unwrap(), 1e-3);
        let Err(ApiError::BadRequest(m)) = export_tolerance(Some(1e-9), 100.0) else {
            panic!("a tolerance below the floor should be refused")
        };
        assert!(
            m.contains("finer than a mesh can be made") && m.contains("1.000e-3"),
            "{m}"
        );
        // A point has no size; tolerances are relative to 1
        assert_eq!(export_tolerance(None, 0.0).unwrap(), 1e-3);
    }

    #[test]
    fn render_tolerances() {
        assert_eq!(render_tolerance(0.2, 100.0), 0.1);
        assert_eq!(render_tolerance(1e-6, 100.0), 1e-2);
    }

    #[test]
    fn meshes_and_enforces_the_triangle_limit() {
        let shape = eval_shape("cube(10)").unwrap();
        let m = mesh(&shape, 0.1, 100).unwrap();
        assert_eq!(m.triangle_count(), 12);
        let Err(ApiError::LimitExceeded(msg)) = mesh(&shape, 0.1, 11) else {
            panic!("expected a limit error")
        };
        assert!(msg.contains("12 triangles"), "{msg}");
        assert!(matches!(
            mesh(&shape, -1.0, 100),
            Err(ApiError::MeshFailed(m)) if m.contains("tolerance")
        ));
    }

    #[test]
    fn a_cube_has_twelve_sharp_edges() {
        let shape = eval_shape("cube(10)").unwrap();
        let welded = mesh(&shape, 0.1, 1000).unwrap().welded();
        let edges = sharp_edges(&welded);
        // Each side of the cube is meshed in one segment
        assert_eq!(edges.len(), 12);
        for [a, b] in &edges {
            assert!((a.distance(*b) - 10.0).abs() < 1e-9);
        }
    }

    #[test]
    fn tangent_and_seam_edges_are_not_sharp() {
        // A cylinder's side meets its caps at 90 degrees, but its seam joins
        // the side to itself; a filleted edge joins tangentially.
        let cylinder = eval_shape("cylinder(5, 10)").unwrap();
        let welded = mesh(&cylinder, 0.01, 100_000).unwrap().welded();
        let edges = sharp_edges(&welded);
        assert!(!edges.is_empty());
        for [a, b] in &edges {
            assert!(a.z == b.z && (a.z.abs() < 1e-9 || (a.z - 10.0).abs() < 1e-9));
        }

        let rounded = eval_shape("box(10, 10, 10).fillet(2, \"|Z\")").unwrap();
        let welded = mesh(&rounded, 0.01, 100_000).unwrap().welded();
        // Only the top and bottom outlines remain
        for [a, b] in &sharp_edges(&welded) {
            assert!(a.z == b.z, "{a} {b}");
        }
    }

    #[test]
    fn open_faces_draw_their_border() {
        let face = eval_shape("box(4, 4, 4).faces(\">Z\")").unwrap();
        let welded = mesh(&face, 0.1, 1000).unwrap().welded();
        assert_eq!(sharp_edges(&welded).len(), 4);
    }

    #[test]
    fn sampled_edges_follow_lines_and_curves() {
        let square = eval_shape("rect(2, 2)").unwrap();
        assert_eq!(sampled_edges(&square).len(), 4);
        let circle = eval_shape("circle(1)").unwrap();
        let segments = sampled_edges(&circle);
        assert_eq!(segments.len(), CURVE_SAMPLES);
        assert!(
            segments
                .iter()
                .all(|[a, _]| (a.length() - 1.0).abs() < 1e-9)
        );
    }
}
