mod common;

use common::{assert_close, assert_vec_close, cube10, err, err_contains, v};
use scratchcad_occt_rhai::{ffi, DVec3, Error, Plane, Shape, ShapeType};
use std::f64::consts::PI;

#[test]
fn booleans() {
    let a = Shape::cube(2.0).unwrap();
    let b = a.translate(DVec3::ONE).unwrap();
    let fused = a.fuse(&b).unwrap();
    assert_eq!(fused.shape_type(), ShapeType::Solid, "single-solid results are unwrapped");
    assert_close(fused.volume().unwrap(), 15.0, 1e-6);
    assert_close(a.cut(&b).unwrap().volume().unwrap(), 7.0, 1e-6);
    assert_close(a.common(&b).unwrap().volume().unwrap(), 1.0, 1e-6);
    let section = a.section(&b).unwrap();
    assert_eq!(section.edges().len(), 6);
    assert_close(section.length().unwrap(), 6.0, 1e-6);

    let far = a.translate(v(10.0, 0.0, 0.0)).unwrap();
    let disjoint = a.fuse(&far).unwrap();
    assert_eq!(disjoint.shape_type(), ShapeType::Compound);
    assert_eq!(disjoint.solids().len(), 2);
    assert_close(a.common(&far).unwrap().volume().unwrap(), 0.0, 1e-9);

    let all = Shape::fuse_all(&[a.clone(), b, far]).unwrap();
    assert_close(all.volume().unwrap(), 23.0, 1e-6);
    assert_eq!(Shape::fuse_all(std::slice::from_ref(&a)).unwrap(), a);
    err_contains(Shape::fuse_all(&[]), "at least one shape");
}

#[test]
fn transforms() {
    let cube = Shape::cube(2.0).unwrap();
    let moved = cube.translate(v(1.0, 2.0, 3.0)).unwrap();
    assert_vec_close(moved.center().unwrap(), v(2.0, 3.0, 4.0), 1e-9);
    assert_vec_close(cube.center().unwrap(), DVec3::ONE, 1e-9);
    err_contains(cube.translate(v(f64::NAN, 0.0, 0.0)), "translation must be finite");

    let rotated = cube.rotate(DVec3::ZERO, DVec3::Z, 90.0).unwrap();
    assert_vec_close(rotated.center().unwrap(), v(-1.0, 1.0, 1.0), 1e-9);
    let around_point = cube.rotate(DVec3::ONE, DVec3::Z, 180.0).unwrap();
    assert_vec_close(around_point.center().unwrap(), DVec3::ONE, 1e-9);
    err_contains(cube.rotate(DVec3::ZERO, DVec3::ZERO, 90.0), "non-zero");
    err_contains(cube.rotate(DVec3::ZERO, DVec3::Z, f64::INFINITY), "rotation angle");
    err_contains(cube.rotate(v(f64::INFINITY, 0.0, 0.0), DVec3::Z, 90.0), "axis origin");

    let scaled = cube.scale(DVec3::ZERO, 2.0).unwrap();
    assert_close(scaled.volume().unwrap(), 64.0, 1e-9);
    let about_center = cube.scale(DVec3::ONE, 0.5).unwrap();
    assert_vec_close(about_center.center().unwrap(), DVec3::ONE, 1e-9);
    let flipped = cube.scale(DVec3::ZERO, -1.0).unwrap();
    assert_vec_close(flipped.center().unwrap(), -DVec3::ONE, 1e-9);
    err_contains(cube.scale(DVec3::ZERO, 0.0), "must not be zero");
    err_contains(cube.scale(DVec3::ZERO, f64::NAN), "scale factor");

    let mirrored = cube.mirror(DVec3::ZERO, DVec3::X).unwrap();
    assert_vec_close(mirrored.center().unwrap(), v(-1.0, 1.0, 1.0), 1e-9);
    let mirrored = cube.mirror(v(0.0, 0.0, 5.0), DVec3::Z).unwrap();
    assert_vec_close(mirrored.center().unwrap(), v(1.0, 1.0, 9.0), 1e-9);
    assert_close(mirrored.volume().unwrap(), 8.0, 1e-9);
    err_contains(cube.mirror(DVec3::ZERO, DVec3::ZERO), "non-zero");
}

#[test]
fn extrusions() {
    let square = Shape::rect_on(&Plane::xy(), 2.0, 3.0).unwrap();
    let prism = square.extrude(v(0.0, 0.0, 4.0)).unwrap();
    assert_eq!(prism.shape_type(), ShapeType::Solid);
    assert_close(prism.volume().unwrap(), 24.0, 1e-9);

    let face = Shape::face_from(&square).unwrap();
    assert_close(face.extrude(v(1.0, 0.0, 1.0)).unwrap().volume().unwrap(), 6.0, 1e-9);
    let up = square.extrude_normal(4.0).unwrap();
    assert_close(up.bounding_box().unwrap().max.z, 4.0, 1e-9);
    let down = square.extrude_normal(-4.0).unwrap();
    assert_close(down.bounding_box().unwrap().min.z, -4.0, 1e-9);
    err_contains(square.extrude_normal(f64::NAN), "extrusion distance");

    let edge = Shape::line(DVec3::ZERO, DVec3::X).unwrap();
    let sheet = edge.extrude(DVec3::Y).unwrap();
    assert_eq!(sheet.shape_type(), ShapeType::Face);
    assert_close(sheet.area().unwrap(), 1.0, 1e-9);
    err_contains(edge.extrude_normal(1.0), "expected face, got edge");
    let vertex = Shape::vertex_at(DVec3::ZERO).unwrap();
    let stick = vertex.extrude(DVec3::Z * 3.0).unwrap();
    assert_eq!(stick.shape_type(), ShapeType::Edge);
    assert_close(stick.length().unwrap(), 3.0, 1e-9);
    err_contains(square.extrude(DVec3::ZERO), "must be non-zero");
}

#[test]
fn revolutions_sweeps_and_lofts() {
    let profile =
        Shape::rect_on(&Plane::named("XZ").unwrap().translated(v(3.0, 0.0, 0.0)), 2.0, 2.0)
            .unwrap();
    let ring = profile.revolve(DVec3::ZERO, DVec3::Z, 360.0).unwrap();
    assert_close(ring.volume().unwrap(), PI * (16.0 - 4.0) * 2.0, 1e-6);
    let half = profile.revolve(DVec3::ZERO, DVec3::Z, 180.0).unwrap();
    assert_close(half.volume().unwrap(), PI * 12.0, 1e-6);
    err_contains(profile.revolve(DVec3::ZERO, DVec3::Z, 0.0), "(0, 360]");
    err_contains(profile.revolve(DVec3::ZERO, DVec3::Z, 400.0), "(0, 360]");
    err_contains(profile.revolve(DVec3::ZERO, DVec3::Z, f64::NAN), "revolution angle");

    let path = Shape::line(DVec3::ZERO, v(0.0, 0.0, 10.0)).unwrap();
    let circle = Shape::circle(DVec3::ZERO, DVec3::Z, 1.0).unwrap();
    let rod = circle.sweep(&path).unwrap();
    assert_close(rod.volume().unwrap(), 10.0 * PI, 1e-6);
    let path_wire = Shape::wire_from(std::slice::from_ref(&path)).unwrap();
    assert_close(circle.sweep(&path_wire).unwrap().volume().unwrap(), 10.0 * PI, 1e-6);
    err_contains(circle.sweep(&Shape::cube(1.0).unwrap()), "expected edge or wire, got solid");

    let bottom = Shape::circle(DVec3::ZERO, DVec3::Z, 1.0).unwrap();
    let top = Shape::circle(v(0.0, 0.0, 2.0), DVec3::Z, 2.0).unwrap();
    let frustum = Shape::loft(&[bottom.clone(), top.clone()], true).unwrap();
    assert_eq!(frustum.shape_type(), ShapeType::Solid);
    assert_close(frustum.volume().unwrap(), 14.0 * PI / 3.0, 1e-4);
    let skin = Shape::loft(&[bottom.clone(), top.clone()], false).unwrap();
    assert_eq!(skin.shape_type(), ShapeType::Shell);
    let from_faces =
        Shape::loft(&[Shape::face_from(&bottom).unwrap(), Shape::face_from(&top).unwrap()], true)
            .unwrap();
    assert_close(from_faces.volume().unwrap(), 14.0 * PI / 3.0, 1e-4);
    let from_edges =
        Shape::loft(&[bottom.edges().first().unwrap(), top.edges().first().unwrap()], true)
            .unwrap();
    assert_close(from_edges.volume().unwrap(), 14.0 * PI / 3.0, 1e-4);
    err_contains(Shape::loft(&[bottom], true), "at least 2 sections");
    err_contains(Shape::loft(&[Shape::cube(1.0).unwrap(), top], true), "expected wire, got solid");
}

#[test]
fn fillets_and_chamfers() {
    let cube = cube10();
    let rounded = cube.fillet_all(1.0).unwrap();
    assert_eq!(rounded.shape_type(), ShapeType::Solid);
    assert_close(rounded.volume().unwrap(), 896.0 + 24.0 * PI + 4.0 / 3.0 * PI, 1e-3);
    let vertical = cube.edges().parallel_to(DVec3::Z).unwrap();
    let rounded_sides = cube.fillet(2.0, vertical.shapes()).unwrap();
    assert_close(rounded_sides.volume().unwrap(), 1000.0 - 4.0 * 10.0 * (4.0 - PI), 1e-3);
    err_contains(cube.fillet(0.0, vertical.shapes()), "fillet radius");
    assert!(matches!(err(cube.fillet(1.0, &[])), Error::EmptySelection(_)));
    err_contains(cube.fillet(1.0, &[cube.faces().first().unwrap()]), "expected edge, got face");
    let too_big = cube.fillet(20.0, cube.edges().shapes());
    assert!(too_big.is_err(), "a fillet larger than the box must fail");

    let one_edge = cube.chamfer(1.0, &[cube.edges().first().unwrap()]).unwrap();
    assert_close(one_edge.volume().unwrap(), 995.0, 1e-6);
    let all = cube.chamfer_all(1.0).unwrap();
    assert!(all.volume().unwrap() < 995.0);
    err_contains(cube.chamfer(-1.0, cube.edges().shapes()), "chamfer distance");
    assert!(matches!(err(cube.chamfer(1.0, &[])), Error::EmptySelection(_)));
    assert!(cube.chamfer(30.0, cube.edges().shapes()).is_err());
}

#[test]
fn shells_offsets_and_cleanup() {
    let cube = cube10();
    let top = cube.faces().farthest(DVec3::Z).unwrap();
    let cup = cube.shell(-1.0, top.shapes()).unwrap();
    assert_eq!(cup.shape_type(), ShapeType::Solid);
    assert_close(cup.volume().unwrap(), 1000.0 - 8.0 * 8.0 * 9.0, 1e-6);
    let outward = cube.shell(1.0, top.shapes()).unwrap();
    assert!(outward.volume().unwrap() > 0.0);
    // Without open faces the walls enclose a void.
    let hollow = cube.shell(-1.0, &[]).unwrap();
    assert_close(hollow.volume().unwrap(), 1000.0 - 512.0, 1e-6);
    assert_eq!(hollow.shells().len(), 2);
    let coat = cube.shell(1.0, &[]).unwrap();
    assert!(coat.volume().unwrap() > 12.0 * 12.0 * 12.0 - 1000.0 - 1e-6 - 8.0);
    assert!(coat.bounding_box().unwrap().contains(v(-1.0 + 1e-6, 5.0, 5.0)));
    err_contains(cube.shell(0.0, top.shapes()), "must not be zero");
    err_contains(cube.shell(f64::NAN, &[]), "shell thickness");
    err_contains(cube.shell(1.0, &[cube.edges().first().unwrap()]), "expected face, got edge");

    let square = Shape::rect_on(&Plane::xy(), 4.0, 4.0).unwrap();
    let grown = Shape::face_from(&square).unwrap().offset_2d(1.0).unwrap();
    assert_eq!(grown.shape_type(), ShapeType::Face);
    assert_close(grown.area().unwrap(), 16.0 + 16.0 + PI, 1e-6);
    let wire = square.offset_2d(1.0).unwrap();
    assert_eq!(wire.shape_type(), ShapeType::Wire);
    assert_close(wire.length().unwrap(), 16.0 + 2.0 * PI, 1e-6);
    let shrunk = square.offset_2d(-1.0).unwrap();
    assert_close(shrunk.length().unwrap(), 8.0, 1e-6);
    err_contains(cube.offset_2d(1.0), "expected wire or face, got solid");
    err_contains(square.offset_2d(f64::NAN), "offset distance");

    let a = Shape::cube(1.0).unwrap();
    let b = a.translate(DVec3::X).unwrap();
    let fused = a.fuse(&b).unwrap();
    assert_eq!(fused.faces().len(), 10);
    let clean = fused.clean().unwrap();
    assert_eq!(clean.faces().len(), 6);
    assert_close(clean.volume().unwrap(), 2.0, 1e-9);
}

#[test]
fn measurements_and_queries() {
    let cube = Shape::cube(2.0).unwrap();
    assert!(cube.is_valid());
    assert!(cube.is_closed());
    assert_close(cube.distance(&cube.translate(v(5.0, 0.0, 0.0)).unwrap()).unwrap(), 3.0, 1e-9);
    let (p, q) = cube.closest_points(&Shape::vertex_at(v(5.0, 1.0, 1.0)).unwrap()).unwrap();
    assert_vec_close(p, v(2.0, 1.0, 1.0), 1e-9);
    assert_vec_close(q, v(5.0, 1.0, 1.0), 1e-9);

    // Centers by dimension.
    let wire = Shape::rect_on(&Plane::xy().translated(v(1.0, 1.0, 0.0)), 2.0, 2.0).unwrap();
    assert_vec_close(wire.center().unwrap(), v(1.0, 1.0, 0.0), 1e-9);
    let shell = cube.shells().first().unwrap();
    assert_vec_close(shell.center().unwrap(), DVec3::ONE, 1e-9);
    let faces_only = Shape::compound(cube.faces().shapes()).unwrap();
    assert_vec_close(faces_only.center().unwrap(), DVec3::ONE, 1e-9);
    let edges_only = Shape::compound(cube.edges().shapes()).unwrap();
    assert_vec_close(edges_only.center().unwrap(), DVec3::ONE, 1e-9);
    let vertices_only = Shape::compound(cube.vertices().shapes()).unwrap();
    assert_vec_close(vertices_only.center().unwrap(), DVec3::ONE, 1e-9);
    let solids =
        Shape::compound(&[cube.clone(), cube.translate(v(4.0, 0.0, 0.0)).unwrap()]).unwrap();
    assert_vec_close(solids.center().unwrap(), v(3.0, 1.0, 1.0), 1e-9);

    let bbox = cube.bounding_box().unwrap();
    assert_vec_close(bbox.center(), DVec3::ONE, 1e-9);
    assert_vec_close(bbox.size(), DVec3::splat(2.0), 1e-9);
    assert!(bbox.contains(DVec3::ONE));
    assert!(bbox.contains(DVec3::ZERO));
    assert!(!bbox.contains(v(3.0, 1.0, 1.0)));
    assert!(bbox.to_string().starts_with("BoundingBox(min: ("));

    let top = cube.faces().farthest(DVec3::Z).unwrap().single().unwrap();
    assert_eq!(top.geom_type().unwrap(), "plane");
    assert_vec_close(top.normal().unwrap(), DVec3::Z, 1e-12);
    let plane = top.plane().unwrap();
    assert_vec_close(plane.origin(), v(1.0, 1.0, 2.0), 1e-9);
    assert_vec_close(plane.normal(), DVec3::Z, 1e-12);
    assert_vec_close(wire.normal().unwrap().abs(), DVec3::Z, 1e-12);
    err_contains(cube.normal(), "expected face, got solid");
    err_contains(cube.plane(), "expected face, got solid");
    err_contains(cube.geom_type(), "expected edge or face, got solid");
    err_contains(cube.outer_wire(), "expected face");

    let cylinder = Shape::cylinder(1.0, 2.0).unwrap();
    let side = cylinder.faces().of_type("cylinder").unwrap().single().unwrap();
    err_contains(side.plane(), "only planar faces");
    let n = side.normal().unwrap();
    assert_close(n.z, 0.0, 1e-9);
    assert_close(n.length(), 1.0, 1e-9);
    let kinds: Vec<_> = [
        Shape::sphere(1.0).unwrap(),
        Shape::cone(1.0, 0.0, 1.0).unwrap(),
        Shape::torus(2.0, 1.0).unwrap(),
    ]
    .iter()
    .map(|s| s.faces().first().unwrap().geom_type().unwrap())
    .collect();
    assert_eq!(kinds, ["sphere", "cone", "torus"]);
    let spline = Shape::spline(&[DVec3::ZERO, DVec3::X, v(2.0, 1.0, 0.0)], false).unwrap();
    assert_eq!(spline.extrude(DVec3::Z).unwrap().geom_type().unwrap(), "extrusion");
    let bulge = [(0.0, 1.0), (1.0, 2.0), (2.0, 1.0)]
        .map(|(z, r)| Shape::circle(v(0.0, 0.0, z), DVec3::Z, r).unwrap());
    let lofted = Shape::loft(&bulge, false).unwrap();
    assert!(lofted.faces().iter().all(|f| f.geom_type().unwrap() == "bspline"));
    let revolved = spline.revolve(v(0.0, -5.0, 0.0), DVec3::X, 90.0).unwrap();
    assert_eq!(revolved.geom_type().unwrap(), "revolution");
}

#[test]
fn identity_display_and_raw_access() {
    let cube = Shape::cube(1.0).unwrap();
    let copy = cube.clone();
    assert_eq!(cube, copy);
    assert!(cube.is_same(&copy));
    assert_ne!(cube, Shape::cube(1.0).unwrap());
    assert!(Shape::from_raw(cube.raw()).unwrap().is_same(&cube));
    let null = ffi::topo_ds::TopoDS_Shape_new();
    assert!(matches!(err(Shape::from_raw(&null)), Error::OperationFailed(_)));

    assert_eq!(cube.to_string(), "Shape(solid, 6 faces, 12 edges, 8 vertices)");
    assert_eq!(format!("{cube:?}"), cube.to_string());
    assert_eq!(
        Shape::vertex_at(v(1.0, 2.0, 3.0)).unwrap().to_string(),
        "Shape(vertex at (1, 2, 3))"
    );
    assert_eq!(Shape::line(DVec3::ZERO, DVec3::X).unwrap().to_string(), "Shape(edge, line)");

    let single = Shape::compound(std::slice::from_ref(&cube)).unwrap();
    assert_eq!(single.shape_type(), ShapeType::Compound);
    assert!(single.clone().unwrap_single().is_same(&cube));
    let pair = Shape::compound(&[cube.clone(), cube.translate(DVec3::X * 3.0).unwrap()]).unwrap();
    assert!(pair.clone().unwrap_single().is_same(&pair));
    let nested = Shape::compound(std::slice::from_ref(&pair)).unwrap();
    assert!(nested.clone().unwrap_single().is_same(&nested));
    assert!(cube.clone().unwrap_single().is_same(&cube));
    let empty_child = Shape::compound(&[Shape::empty().unwrap()]).unwrap();
    assert!(empty_child.clone().unwrap_single().is_same(&empty_child));
}

#[test]
fn errors_display_and_convert() {
    let exception = ffi::gp::gp_Dir_new(0.0, 0.0, 0.0).err().unwrap();
    let error = Error::from(exception);
    assert!(error.to_string().starts_with("OpenCASCADE error: Standard_ConstructionError"));
    assert_eq!(Error::OperationFailed("fuse").to_string(), "fuse failed");
    assert_eq!(
        Error::WrongShapeType { expected: "face", actual: "edge" }.to_string(),
        "expected face, got edge"
    );
    assert_eq!(
        Error::IndexOutOfRange { index: -9, len: 2 }.to_string(),
        "index -9 out of range for selection of 2 shapes"
    );
    assert_eq!(Error::Io("nope".into()).to_string(), "nope");
    let rhai_error: Box<scratchcad_occt_rhai::rhai::EvalAltResult> =
        Error::EmptySelection("x".into()).into();
    assert!(rhai_error.to_string().contains("selection is empty: x"));
}
