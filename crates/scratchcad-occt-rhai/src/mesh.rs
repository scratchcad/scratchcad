//! Triangle meshes of shapes, for rendering or STL export.

use crate::{
    cancel::{self, failed, progress},
    error::{invalid, Error, Result},
    math::{from_pnt, require_positive},
    shape::Shape,
};
use glam::DVec3;
use scratchcad_occt_sys as ffi;
use std::{collections::HashMap, fmt, io, ops::Range};

/// How finely [`Shape::mesh_with`] triangulates.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct MeshOptions {
    /// The maximum distance between the mesh and the true surface, in model units (or, when
    /// `relative` is set, as a fraction of each edge's size). Smaller values produce finer
    /// meshes.
    pub tolerance: f64,
    /// The maximum angle, in degrees, between the normals at adjacent mesh nodes along a curved
    /// surface. Small holes and fillets need a small angle to look round.
    pub angular_tolerance: f64,
    /// Whether `tolerance` is relative to the size of each edge rather than absolute.
    pub relative: bool,
    /// Mesh faces on several threads.
    pub parallel: bool,
}

impl MeshOptions {
    /// OpenCASCADE's default angular tolerance (0.5 radians), in degrees.
    pub const DEFAULT_ANGULAR_TOLERANCE: f64 = 28.647_889_756_541_16;

    /// An absolute `tolerance` with the default angular tolerance, meshing on one thread.
    pub fn new(tolerance: f64) -> Self {
        Self {
            tolerance,
            angular_tolerance: Self::DEFAULT_ANGULAR_TOLERANCE,
            relative: false,
            parallel: false,
        }
    }

    pub fn angular_tolerance(self, degrees: f64) -> Self {
        Self { angular_tolerance: degrees, ..self }
    }

    pub fn relative(self, relative: bool) -> Self {
        Self { relative, ..self }
    }

    pub fn parallel(self, parallel: bool) -> Self {
        Self { parallel, ..self }
    }

    fn validate(&self) -> Result<()> {
        require_positive(self.tolerance, "mesh tolerance")?;
        require_positive(self.angular_tolerance, "mesh angular tolerance")?;
        if self.angular_tolerance > 180.0 {
            return Err(invalid(format!(
                "mesh angular tolerance must be at most 180 degrees, got {}",
                self.angular_tolerance
            )));
        }
        Ok(())
    }
}

/// An indexed triangle mesh. Every three entries of `indices` form one counter-clockwise
/// (outward-facing) triangle; `normals[i]` is the surface normal at `vertices[i]`.
///
/// [`Shape::mesh`] triangulates each face separately, so vertices on an edge between two faces
/// appear once per face (each with that face's normal); [`Mesh::welded`] merges them.
#[derive(Debug, Clone, Default, PartialEq)]
pub struct Mesh {
    pub vertices: Vec<DVec3>,
    pub normals: Vec<DVec3>,
    pub indices: Vec<usize>,
    /// The triangles of each face, as ranges of triangle numbers (triangle `t` is
    /// `indices[3 * t..3 * t + 3]`), in the order of [`Shape::faces`].
    pub face_triangles: Vec<Range<usize>>,
}

impl Mesh {
    pub fn vertex_count(&self) -> usize {
        self.vertices.len()
    }

    pub fn triangle_count(&self) -> usize {
        self.indices.len() / 3
    }

    /// The corners of every triangle.
    pub fn triangles(&self) -> impl Iterator<Item = [DVec3; 3]> + '_ {
        self.indices
            .as_chunks::<3>()
            .0
            .iter()
            .map(|&[a, b, c]| [self.vertices[a], self.vertices[b], self.vertices[c]])
    }

    /// The total area of all triangles.
    pub fn area(&self) -> f64 {
        self.triangles().map(|[a, b, c]| (b - a).cross(c - a).length() / 2.0).sum()
    }

    /// The face each triangle belongs to (an index into [`Shape::faces`]).
    pub fn triangle_faces(&self) -> Vec<usize> {
        let mut faces = vec![0; self.triangle_count()];
        for (face, range) in self.face_triangles.iter().enumerate() {
            faces[range.clone()].fill(face);
        }
        faces
    }

    /// The mesh with coincident vertices merged, so that triangles on either side of an edge
    /// share their vertices: the mesh of a closed solid is then watertight. Each merged vertex
    /// gets the average of the merged normals. Triangles that collapse are dropped.
    pub fn welded(&self) -> Mesh {
        let extent = self.vertices.iter().fold(0.0_f64, |m, v| m.max(v.abs().max_element()));
        // OpenCASCADE computes the nodes on an edge once and gives them to both faces, so they
        // match to within rounding of the faces' placements.
        let cell = extent.max(1.0) * 1e-10;
        let key = |v: DVec3| (v / cell).round().as_i64vec3().to_array();

        let mut cells: HashMap<[i64; 3], usize> = HashMap::new();
        let mut welded = Mesh::default();
        let mut normal_sums: Vec<DVec3> = Vec::new();
        let mut remap = Vec::with_capacity(self.vertices.len());
        for (vertex, normal) in self.vertices.iter().zip(&self.normals) {
            let [x, y, z] = key(*vertex);
            let nearby = (-1..=1)
                .flat_map(|dx| (-1..=1).flat_map(move |dy| (-1..=1).map(move |dz| (dx, dy, dz))))
                .filter_map(|(dx, dy, dz)| cells.get(&[x + dx, y + dy, z + dz]).copied())
                .find(|&i| welded.vertices[i].distance(*vertex) <= cell);
            let index = nearby.unwrap_or_else(|| {
                welded.vertices.push(*vertex);
                normal_sums.push(DVec3::ZERO);
                cells.insert([x, y, z], welded.vertices.len() - 1);
                welded.vertices.len() - 1
            });
            normal_sums[index] += *normal;
            remap.push(index);
        }
        welded.normals = normal_sums.into_iter().map(|n| n.normalize_or_zero()).collect();

        for range in &self.face_triangles {
            let start = welded.triangle_count();
            for &[a, b, c] in self.indices[3 * range.start..3 * range.end].as_chunks::<3>().0 {
                let [a, b, c] = [remap[a], remap[b], remap[c]];
                if a != b && b != c && a != c {
                    welded.indices.extend([a, b, c]);
                }
            }
            welded.face_triangles.push(start..welded.triangle_count());
        }
        welded
    }

    /// Writes a binary STL file. Facet normals are computed from the triangles' corners.
    pub fn write_stl(&self, out: &mut impl io::Write) -> io::Result<()> {
        let count = u32::try_from(self.triangle_count()).map_err(|_| {
            io::Error::new(io::ErrorKind::InvalidInput, "too many triangles for an STL file")
        })?;
        let mut header = [b' '; 80];
        let title = b"binary STL written by scratchcad-occt-rhai";
        header[..title.len()].copy_from_slice(title);
        out.write_all(&header)?;
        out.write_all(&count.to_le_bytes())?;
        let mut record = [0u8; 50];
        for corners in self.triangles() {
            let values = std::iter::once(facet_normal(corners)).chain(corners);
            for (i, value) in values.enumerate() {
                for (j, component) in value.to_array().into_iter().enumerate() {
                    let at = 12 * i + 4 * j;
                    record[at..at + 4].copy_from_slice(&(component as f32).to_le_bytes());
                }
            }
            out.write_all(&record)?;
        }
        Ok(())
    }

    /// Writes an ASCII STL file (about five times the size of [`write_stl`](Mesh::write_stl)).
    pub fn write_stl_ascii(&self, out: &mut impl io::Write) -> io::Result<()> {
        writeln!(out, "solid shape")?;
        for corners in self.triangles() {
            let n = facet_normal(corners);
            writeln!(out, "  facet normal {:e} {:e} {:e}", n.x, n.y, n.z)?;
            writeln!(out, "    outer loop")?;
            for v in corners {
                writeln!(out, "      vertex {:e} {:e} {:e}", v.x, v.y, v.z)?;
            }
            writeln!(out, "    endloop")?;
            writeln!(out, "  endfacet")?;
        }
        writeln!(out, "endsolid shape")
    }

    /// The mesh as a binary STL file.
    pub fn to_stl(&self) -> Vec<u8> {
        let mut bytes = Vec::with_capacity(84 + 50 * self.triangle_count());
        // Writing to a Vec cannot fail, and the triangle count was produced from a `Vec`.
        self.write_stl(&mut bytes).expect("writing an STL file to memory");
        bytes
    }
}

/// Why meshing failed on `count` faces, the first of them `face`: which face it is and where,
/// so the model can find it. OpenCASCADE gives no reason, and its checker can pass the shape.
fn unmeshable(face: &Shape, count: usize) -> Error {
    let kind = face.geom_type().unwrap_or("other");
    let place = match face.bounding_box() {
        Ok(b) => format!(
            " around {}, within {} to {}",
            rounded((b.min + b.max) / 2.0),
            rounded(b.min),
            rounded(b.max)
        ),
        Err(_) => String::new(),
    };
    let others = match count {
        1 => String::new(),
        n => format!(" (and {} more faces)", n - 1),
    };
    invalid(format!(
        "OpenCASCADE could not mesh the {kind} face{place}{others}. That happens where the face \
         lies on another or meets it along a line, such as a cylinder with the same radius as the \
         crest of a thread that touches it, even when OpenCASCADE's checker passes the shape: \
         make one of them a little larger or smaller, by a few hundredths of a millimetre"
    ))
}

/// A point to the nearest thousandth, for messages.
fn rounded(p: DVec3) -> String {
    let round = |x: f64| (x * 1000.0).round() / 1000.0 + 0.0;
    format!("({}, {}, {})", round(p.x), round(p.y), round(p.z))
}

fn facet_normal([a, b, c]: [DVec3; 3]) -> DVec3 {
    (b - a).cross(c - a).normalize_or_zero()
}

impl fmt::Display for Mesh {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Mesh({} vertices, {} triangles)", self.vertex_count(), self.triangle_count())
    }
}

impl Shape {
    /// Triangulates every face. `tolerance` is the maximum distance between the mesh and the
    /// true surface; smaller values produce finer meshes. See [`mesh_with`](Shape::mesh_with)
    /// for more control.
    pub fn mesh(&self, tolerance: f64) -> Result<Mesh> {
        self.mesh_with(&MeshOptions::new(tolerance))
    }

    /// Triangulates every face with the given options.
    ///
    /// The shape itself is left untouched: OpenCASCADE stores triangulations in the faces it
    /// meshes, so the mesh is computed on a [deep copy](Shape::deep_copy). Meshing the same
    /// shape again therefore always honours the new options.
    pub fn mesh_with(&self, options: &MeshOptions) -> Result<Mesh> {
        options.validate()?;
        cancel::check()?;
        let copy = self.deep_copy()?;
        let mesher = ffi::b_rep_mesh::IncrementalMesh_with_parameters(
            copy.raw(),
            options.tolerance,
            options.angular_tolerance.to_radians(),
            options.relative,
            options.parallel,
            &progress(),
        )?;
        if !mesher.IsDone() {
            return Err(failed("meshing"));
        }
        // A mesher that was asked to stop may leave faces without a triangulation.
        cancel::check()?;

        let mut mesh = Mesh::default();
        let mut unmeshed = Vec::new();
        for face in copy.faces() {
            let topo_face = face.face()?;
            let reversed =
                topo_face.Orientation() == ffi::top_abs::TopAbs_Orientation::TopAbs_REVERSED;

            let mut location = ffi::top_loc::Location_new();
            let handle = ffi::b_rep::BRep_Tool_Triangulation(topo_face, location.pin_mut())?;
            let Ok(triangulation) = ffi::poly::Handle_Poly_Triangulation_Get(&handle) else {
                unmeshed.push(face.clone());
                continue;
            };
            let transform = ffi::top_loc::TopLoc_Location_Transformation(&location);
            ffi::b_rep_lib::BRepLib_ToolTriangulatedShape::ComputeNormals(topo_face, &handle)?;

            let offset = mesh.vertices.len();
            for i in 1..=triangulation.NbNodes() {
                let mut node = ffi::poly::Poly_Triangulation_Node(triangulation, i)?;
                node.pin_mut().Transform(&transform);
                mesh.vertices.push(from_pnt(&node));

                let mut normal = ffi::poly::Poly_Triangulation_Normal(triangulation, i)?;
                normal.pin_mut().Transform(&transform);
                let normal = DVec3::new(normal.X(), normal.Y(), normal.Z());
                mesh.normals.push(if reversed { -normal } else { normal });
            }

            let first = mesh.triangle_count();
            for i in 1..=triangulation.NbTriangles() {
                let triangle = triangulation.Triangle(i)?;
                let corner =
                    |n: i32| -> Result<usize> { Ok(offset + triangle.Value(n)? as usize - 1) };
                let (a, b, c) = (corner(1)?, corner(2)?, corner(3)?);
                mesh.indices.extend(if reversed { [a, c, b] } else { [a, b, c] });
            }
            mesh.face_triangles.push(first..mesh.triangle_count());
        }
        match unmeshed.first() {
            Some(face) => Err(unmeshable(face, unmeshed.len())),
            None => Ok(mesh),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    // One face holding one triangle, so a single range is meant.
    #[allow(clippy::single_range_in_vec_init)]
    fn triangle_mesh() -> Mesh {
        Mesh {
            vertices: vec![DVec3::ZERO, DVec3::X, DVec3::Y],
            normals: vec![DVec3::Z; 3],
            indices: vec![0, 1, 2],
            face_triangles: vec![0..1],
        }
    }

    #[test]
    fn binary_stl_layout() {
        let bytes = triangle_mesh().to_stl();
        assert_eq!(bytes.len(), 84 + 50);
        assert!(!bytes.starts_with(b"solid"));
        assert_eq!(u32::from_le_bytes(bytes[80..84].try_into().unwrap()), 1);
        let float = |at: usize| f32::from_le_bytes(bytes[at..at + 4].try_into().unwrap());
        // Normal, then the corners.
        assert_eq!([float(84), float(88), float(92)], [0.0, 0.0, 1.0]);
        assert_eq!([float(108), float(112), float(116)], [1.0, 0.0, 0.0]);
        assert_eq!(&bytes[132..134], &[0, 0]);
    }

    #[test]
    fn ascii_stl_layout() {
        let mut out = Vec::new();
        triangle_mesh().write_stl_ascii(&mut out).unwrap();
        let text = String::from_utf8(out).unwrap();
        assert!(text.starts_with("solid shape\n"));
        assert!(text.contains("facet normal 0e0 0e0 1e0"));
        assert_eq!(text.matches("vertex").count(), 3);
        assert!(text.trim_end().ends_with("endsolid shape"));
    }

    #[test]
    fn welding_merges_coincident_vertices_and_drops_collapsed_triangles() {
        let mesh = Mesh {
            vertices: vec![
                DVec3::ZERO,
                DVec3::X,
                DVec3::Y,
                // A second face sharing the edge (0,0,0)-(1,0,0), with float noise.
                DVec3::new(1e-14, 0.0, 0.0),
                DVec3::X,
                DVec3::NEG_Y,
                // A triangle that collapses once welded.
                DVec3::ZERO,
                DVec3::ZERO,
                DVec3::X,
            ],
            normals: vec![
                DVec3::Z,
                DVec3::Z,
                DVec3::Z,
                DVec3::Y,
                DVec3::Y,
                DVec3::Y,
                DVec3::Z,
                DVec3::Z,
                DVec3::Z,
            ],
            indices: vec![0, 1, 2, 3, 5, 4, 6, 7, 8],
            face_triangles: vec![0..1, 1..2, 2..3],
        };
        let welded = mesh.welded();
        assert_eq!(welded.vertex_count(), 4);
        assert_eq!(welded.indices, vec![0, 1, 2, 0, 3, 1]);
        assert_eq!(welded.face_triangles, vec![0..1, 1..2, 2..2]);
        assert_eq!(welded.triangle_faces(), vec![0, 1]);
        // Merged vertices average the normals of every vertex merged into them.
        let expected = (DVec3::Y + 3.0 * DVec3::Z).normalize();
        assert!(welded.normals[0].abs_diff_eq(expected, 1e-12));
        assert_eq!(welded.normals[2], DVec3::Z);
    }

    #[test]
    fn options_are_validated() {
        assert!(MeshOptions::new(0.1).validate().is_ok());
        assert!(MeshOptions::new(0.0).validate().is_err());
        assert!(MeshOptions::new(0.1).angular_tolerance(0.0).validate().is_err());
        assert!(MeshOptions::new(0.1).angular_tolerance(181.0).validate().is_err());
        let options = MeshOptions::new(0.1).angular_tolerance(5.0).relative(true).parallel(true);
        assert_eq!(
            options,
            MeshOptions { tolerance: 0.1, angular_tolerance: 5.0, relative: true, parallel: true }
        );
        assert!((MeshOptions::DEFAULT_ANGULAR_TOLERANCE.to_radians() - 0.5).abs() < 1e-12);
    }
}
