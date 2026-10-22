mod common;

use common::{assert_close, cube10, err_contains};
use scratchcad_occt_rhai::{DVec3, Mesh, MeshOptions, Shape};
use std::{collections::HashMap, f64::consts::PI};

#[test]
fn box_mesh() {
    let cube = cube10();
    let mesh = cube.mesh(0.1).unwrap();
    assert_eq!(mesh.triangle_count(), 12);
    assert_eq!(mesh.vertex_count(), 24, "each face has its own 4 corners");
    assert_eq!(mesh.normals.len(), mesh.vertices.len());
    assert_close(mesh.area(), 600.0, 1e-9);
    assert_eq!(mesh.triangles().count(), 12);
    assert_eq!(mesh.to_string(), "Mesh(24 vertices, 12 triangles)");

    // Normals and winding both point outwards.
    let center = cube.center().unwrap();
    for (vertex, normal) in mesh.vertices.iter().zip(&mesh.normals) {
        assert!((*vertex - center).dot(*normal) > 0.0, "inward normal {normal} at {vertex}");
    }
    for [a, b, c] in mesh.triangles() {
        let winding = (b - a).cross(c - a);
        assert!(winding.dot((a + b + c) / 3.0 - center) > 0.0);
    }
}

#[test]
fn curved_meshes_converge() {
    let sphere = Shape::sphere(2.0).unwrap();
    let coarse = sphere.mesh(0.1).unwrap();
    let fine = sphere.mesh(0.001).unwrap();
    assert!(fine.triangle_count() > coarse.triangle_count());
    let exact = 16.0 * PI;
    assert!((fine.area() - exact).abs() < (coarse.area() - exact).abs());
    assert_close(fine.area(), exact, 0.05);
    for (vertex, normal) in fine.vertices.iter().zip(&fine.normals) {
        assert!(vertex.dot(*normal) > 0.0);
    }
    // Reversed faces (from a mirror) still yield outward normals.
    let mirrored = Shape::cylinder(1.0, 1.0).unwrap().scale(glam::DVec3::ZERO, -1.0).unwrap();
    let mesh = mirrored.mesh(0.01).unwrap();
    let center = mirrored.center().unwrap();
    let outward = mesh
        .vertices
        .iter()
        .zip(&mesh.normals)
        .filter(|(p, n)| (**p - center).dot(**n) > 0.0)
        .count();
    assert_eq!(outward, mesh.vertices.len());
}

#[test]
fn invalid_tolerances_and_empty_shapes() {
    err_contains(cube10().mesh(0.0), "mesh tolerance");
    err_contains(cube10().mesh(f64::NAN), "mesh tolerance");
    let empty = Shape::empty().unwrap().mesh(0.1).unwrap();
    assert_eq!(empty, Mesh::default());
    assert_eq!(empty.triangle_count(), 0);
    assert_eq!(empty.area(), 0.0);
}

#[test]
fn face_triangles_follow_the_faces() {
    let cube = cube10();
    let mesh = cube.mesh(0.1).unwrap();
    let faces = cube.faces();
    assert_eq!(mesh.face_triangles.len(), faces.len());
    let mut next = 0;
    for (range, face) in mesh.face_triangles.iter().zip(faces.iter()) {
        assert_eq!(range.start, next, "ranges are contiguous");
        assert_eq!(range.len(), 2);
        next = range.end;
        let normal = face.normal().unwrap();
        for t in range.clone() {
            let [a, b, c] = [0, 1, 2].map(|i| mesh.vertices[mesh.indices[3 * t + i]]);
            assert!((b - a).cross(c - a).normalize().abs_diff_eq(normal, 1e-9));
        }
    }
    assert_eq!(next, mesh.triangle_count());
    assert_eq!(mesh.triangle_faces(), vec![0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5]);
}

/// How many triangles use each (undirected) edge.
fn edge_uses(mesh: &Mesh) -> HashMap<(usize, usize), usize> {
    let mut uses = HashMap::new();
    for &[x, y, z] in mesh.indices.as_chunks::<3>().0 {
        for (a, b) in [(x, y), (y, z), (z, x)] {
            *uses.entry((a.min(b), a.max(b))).or_default() += 1;
        }
    }
    uses
}

#[test]
fn welded_meshes_are_watertight() {
    let welded = cube10().mesh(0.1).unwrap().welded();
    assert_eq!(welded.vertex_count(), 8);
    assert_eq!(welded.triangle_count(), 12);
    assert_close(welded.area(), 600.0, 1e-9);

    let part = Shape::cylinder(2.0, 5.0).unwrap().fillet_all(0.5).unwrap();
    let mesh = part.mesh(0.01).unwrap();
    let welded = mesh.welded();
    assert!(welded.vertex_count() < mesh.vertex_count());
    assert_eq!(welded.face_triangles.len(), mesh.face_triangles.len());
    assert!(edge_uses(&welded).values().all(|&n| n == 2), "every edge has two sides");
    assert!(edge_uses(&mesh).values().any(|&n| n == 1), "unwelded faces are separate");
    // Normals stay unit length and roughly outward.
    for (vertex, normal) in welded.vertices.iter().zip(&welded.normals) {
        assert_close(normal.length(), 1.0, 1e-9);
        let axis = DVec3::new(0.0, 0.0, vertex.z.clamp(0.5, 4.5));
        assert!((*vertex - axis).dot(*normal) > 0.0);
    }
}

#[test]
fn mesh_options() {
    // A small hole needs a finer angle than the default to look round.
    let part = Shape::cube(20.0).unwrap().cut(&Shape::cylinder(0.5, 20.0).unwrap()).unwrap();
    let default = part.mesh_with(&MeshOptions::new(0.1)).unwrap();
    let fine_angle = part.mesh_with(&MeshOptions::new(0.1).angular_tolerance(5.0)).unwrap();
    assert!(fine_angle.triangle_count() > default.triangle_count());

    let parallel = part.mesh_with(&MeshOptions::new(0.1).parallel(true)).unwrap();
    assert!(parallel.triangle_count() > 0);
    let relative = part.mesh_with(&MeshOptions::new(0.001).relative(true)).unwrap();
    assert!(relative.triangle_count() > default.triangle_count());

    err_contains(
        part.mesh_with(&MeshOptions::new(0.1).angular_tolerance(0.0)),
        "angular tolerance",
    );
    err_contains(part.mesh_with(&MeshOptions::new(0.1).angular_tolerance(200.0)), "at most 180");
}

#[test]
fn meshing_leaves_the_shape_untouched() {
    // OpenCASCADE keeps an existing (finer) triangulation when asked for a coarser one, so
    // meshing the shape itself would make the second mesh as fine as the first.
    let sphere = Shape::sphere(2.0).unwrap();
    let fine = sphere.mesh(0.001).unwrap();
    let coarse = sphere.mesh(0.1).unwrap();
    assert!(coarse.triangle_count() < fine.triangle_count());
    assert_eq!(coarse, sphere.mesh(0.1).unwrap());
}

#[test]
fn mesh_failures_name_the_face() {
    // A 1/4-20 thumb screw: a lofted thread, then a neck whose radius equals the thread's crest
    // radius. The shape passes OpenCASCADE's checker, but the neck's cylinder can't be meshed.
    let screw = scratchcad_occt_rhai::eval_shape(
        r#"
        const pitch = 1.27;
        const r_major = 3.175;
        let r_minor = r_major - 0.6134 * pitch;
        let hc = pitch / 16.0;
        let r_root = r_minor - 0.05;
        let hr = min(hc + (r_major - r_root) * 0.57735, 0.42 * pitch);
        let section = polygon([[r_root - 0.3, 0, -hr], [r_root, 0, -hr], [r_major, 0, -hc],
                               [r_major, 0, hc], [r_root, 0, hr], [r_root - 0.3, 0, hr]]);
        let sections = [];
        for i in 0..=(10 * 12) {
            let t = i.to_float() / 12.0;
            sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
        }
        let ridge = loft(sections, true).translate([0, 0, -pitch]);
        let rod = cylinder([0, 0, -pitch - 1.0], "Z", r_minor, 11.0 * pitch + 2.0) + ridge;
        let envelope = sketch("XZ").move_to(0, -0.3).hline_to(r_major + 1.0)
            .vline_to(9.5 - (r_major + 1.0 - r_minor + 0.2)).line_to(r_minor - 0.2, 9.5).hline_to(0)
            .close().to_face().revolve("Z", 360);
        (rod & envelope).rotate_x(180.0) + cylinder([0, 0, -0.1], "Z", r_major, 1.8)
    "#,
    )
    .unwrap();
    assert!(screw.is_valid());
    err_contains(screw.mesh(0.01), "could not mesh the cylinder face around (0, 0, 0.8)");
}
