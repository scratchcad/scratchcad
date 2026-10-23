mod common;

use common::{assert_close, assert_vec_close, err, err_contains, v};
use scratchcad_occt_rhai::{DVec3, Error, Plane, Shape, ShapeType};
use std::f64::consts::PI;

#[test]
fn boxes() {
    let b = Shape::make_box(1.0, 2.0, 3.0).unwrap();
    assert_eq!(b.shape_type(), ShapeType::Solid);
    assert!(b.is(ShapeType::Solid));
    assert_close(b.volume().unwrap(), 6.0, 1e-9);
    assert_close(b.area().unwrap(), 22.0, 1e-9);
    assert_close(b.length().unwrap(), 24.0, 1e-9);
    assert_eq!((b.faces().len(), b.edges().len(), b.vertices().len()), (6, 12, 8));
    assert_eq!((b.wires().len(), b.shells().len(), b.solids().len()), (6, 1, 1));

    let centered = Shape::box_centered(2.0, 4.0, 6.0).unwrap();
    let bbox = centered.bounding_box().unwrap();
    assert_vec_close(bbox.min, v(-1.0, -2.0, -3.0), 1e-9);
    assert_vec_close(bbox.max, v(1.0, 2.0, 3.0), 1e-9);

    let corners = Shape::box_from_corners(v(1.0, 1.0, 1.0), v(0.0, 3.0, 0.0)).unwrap();
    assert_close(corners.volume().unwrap(), 2.0, 1e-9);

    // Negative sizes extend along the negative axes.
    let negative = Shape::make_box(-1.0, 2.0, 3.0).unwrap();
    assert_close(negative.bounding_box().unwrap().min.x, -1.0, 1e-9);

    assert_close(Shape::cube(2.0).unwrap().volume().unwrap(), 8.0, 1e-9);
    err_contains(Shape::make_box(0.0, 1.0, 1.0), "box x size must be positive");
    err_contains(Shape::make_box(1.0, f64::NAN, 1.0), "box y size");
    err_contains(Shape::cube(0.0), "box x size");
    err_contains(Shape::make_box(1.0, 1.0, 0.0), "box z size");
}

#[test]
fn round_primitives() {
    let cylinder = Shape::cylinder(1.0, 2.0).unwrap();
    assert_close(cylinder.volume().unwrap(), 2.0 * PI, 1e-6);
    let along_x = Shape::cylinder_at(v(1.0, 0.0, 0.0), DVec3::X, 1.0, 5.0).unwrap();
    let bbox = along_x.bounding_box().unwrap();
    assert_close(bbox.min.x, 1.0, 1e-6);
    assert_close(bbox.max.x, 6.0, 1e-6);
    err_contains(Shape::cylinder(0.0, 1.0), "cylinder radius");
    err_contains(Shape::cylinder(1.0, -1.0), "cylinder height");
    err_contains(Shape::cylinder_at(DVec3::ZERO, DVec3::ZERO, 1.0, 1.0), "non-zero");

    assert_close(Shape::sphere(2.0).unwrap().volume().unwrap(), 32.0 * PI / 3.0, 1e-6);
    let moved = Shape::sphere_at(v(5.0, 0.0, 0.0), 1.0).unwrap();
    assert_vec_close(moved.center().unwrap(), v(5.0, 0.0, 0.0), 1e-6);
    err_contains(Shape::sphere(-1.0), "sphere radius");
    err_contains(Shape::sphere_at(v(f64::NAN, 0.0, 0.0), 1.0), "axis origin must be finite");
    let far_plane = Plane::xy().offset(f64::INFINITY);
    err_contains(Shape::circle_on(&far_plane, 1.0), "plane origin must be finite");

    assert_close(Shape::cone(1.0, 0.0, 3.0).unwrap().volume().unwrap(), PI, 1e-6);
    assert_close(Shape::cone(2.0, 1.0, 3.0).unwrap().volume().unwrap(), 7.0 * PI, 1e-6);
    err_contains(Shape::cone(1.0, 1.0, 1.0), "radii must differ");
    err_contains(Shape::cone(-1.0, 1.0, 1.0), "bottom radius");
    err_contains(Shape::cone(1.0, -1.0, 1.0), "top radius");
    err_contains(Shape::cone(1.0, 0.0, 0.0), "cone height");

    assert_close(Shape::torus(3.0, 1.0).unwrap().volume().unwrap(), 6.0 * PI * PI, 1e-6);
    err_contains(Shape::torus(0.0, 1.0), "major radius");
    err_contains(Shape::torus(1.0, 0.0), "minor radius");
    // A tube as wide as its ring, or wider, crosses itself.
    err_contains(Shape::torus(1.0, 1.0), "must be smaller than its major radius, got 1 and 1");
    err_contains(Shape::torus(1.0, 2.0), "a tube that wide crosses itself");
}

#[test]
fn vertices_and_edges() {
    let vertex = Shape::vertex_at(v(1.0, 2.0, 3.0)).unwrap();
    assert_eq!(vertex.shape_type(), ShapeType::Vertex);
    assert_eq!(vertex.point().unwrap(), v(1.0, 2.0, 3.0));
    assert_vec_close(vertex.center().unwrap(), v(1.0, 2.0, 3.0), 0.0);
    err_contains(Shape::vertex_at(v(f64::INFINITY, 0.0, 0.0)), "finite");

    let line = Shape::line(DVec3::ZERO, v(3.0, 4.0, 0.0)).unwrap();
    assert_eq!(line.shape_type(), ShapeType::Edge);
    assert_close(line.length().unwrap(), 5.0, 1e-9);
    assert_eq!(line.geom_type().unwrap(), "line");
    assert_vec_close(line.line_direction().unwrap(), v(0.6, 0.8, 0.0), 1e-12);
    assert_vec_close(line.point_at(0.5).unwrap(), v(1.5, 2.0, 0.0), 1e-12);
    assert_vec_close(line.tangent_at(0.0).unwrap(), v(0.6, 0.8, 0.0), 1e-12);
    assert_vec_close(line.start_point().unwrap(), DVec3::ZERO, 1e-12);
    assert_vec_close(line.end_point().unwrap(), v(3.0, 4.0, 0.0), 1e-12);
    assert!(!line.is_closed());
    err_contains(Shape::line(DVec3::ONE, DVec3::ONE), "two distinct finite points");
    err_contains(line.point_at(1.5), "within [0, 1]");
    err_contains(line.point_at(f64::NAN), "finite");
    err_contains(line.radius(), "only circular edges");
    err_contains(line.point(), "expected vertex, got edge");

    let arc = Shape::arc(v(1.0, 0.0, 0.0), v(0.0, 1.0, 0.0), v(-1.0, 0.0, 0.0)).unwrap();
    assert_eq!(arc.geom_type().unwrap(), "circle");
    assert_close(arc.length().unwrap(), PI, 1e-9);
    assert_close(arc.radius().unwrap(), 1.0, 1e-9);
    err_contains(arc.line_direction(), "only straight edges");
    err_contains(Shape::arc(DVec3::ZERO, DVec3::X, v(2.0, 0.0, 0.0)), "collinear");

    let circle = Shape::circle_edge(DVec3::ZERO, DVec3::Z, 2.0).unwrap();
    assert!(circle.is_closed());
    assert_close(circle.length().unwrap(), 4.0 * PI, 1e-9);
    assert_vec_close(circle.tangent_at(0.0).unwrap().abs(), DVec3::Y, 1e-9);
    err_contains(Shape::circle_edge(DVec3::ZERO, DVec3::Z, 0.0), "circle radius");

    let wire = Shape::circle(v(0.0, 0.0, 1.0), DVec3::Z, 1.0).unwrap();
    assert_eq!(wire.shape_type(), ShapeType::Wire);
    assert!(wire.is_closed());
    let on_plane = Shape::circle_on(&Plane::named("XZ").unwrap(), 1.0).unwrap();
    assert_vec_close(on_plane.edges().first().unwrap().start_point().unwrap(), DVec3::X, 1e-9);
}

#[test]
fn splines_and_beziers() {
    let points = [DVec3::ZERO, v(1.0, 1.0, 0.0), v(2.0, 0.0, 0.0), v(3.0, 1.0, 0.0)];
    let spline = Shape::spline(&points, false).unwrap();
    assert_eq!(spline.geom_type().unwrap(), "bspline");
    assert_vec_close(spline.start_point().unwrap(), DVec3::ZERO, 1e-9);
    assert_vec_close(spline.end_point().unwrap(), v(3.0, 1.0, 0.0), 1e-9);
    assert!(!spline.is_closed());

    let closed = Shape::spline(&points[..3], true).unwrap();
    assert!(closed.is_closed());
    let mut with_duplicate = points[..3].to_vec();
    with_duplicate.push(DVec3::ZERO);
    let closed_again = Shape::spline(&with_duplicate, true).unwrap();
    assert_close(closed_again.length().unwrap(), closed.length().unwrap(), 1e-9);

    err_contains(Shape::spline(&[DVec3::ZERO], false), "at least 2 points");
    err_contains(Shape::spline(&[DVec3::ZERO, v(f64::NAN, 0.0, 0.0)], false), "not finite");
    err_contains(Shape::spline(&[DVec3::ZERO, DVec3::ZERO], false), "cannot interpolate");

    let bezier = Shape::bezier(&[DVec3::ZERO, v(1.0, 2.0, 0.0), v(2.0, 0.0, 0.0)]).unwrap();
    assert_eq!(bezier.geom_type().unwrap(), "bezier");
    assert_vec_close(bezier.point_at(0.5).unwrap(), v(1.0, 1.0, 0.0), 1e-9);
    err_contains(Shape::bezier(&[DVec3::ZERO]), "at least 2 control points");
}

#[test]
fn polylines_polygons_and_rectangles() {
    let polyline = Shape::polyline(&[DVec3::ZERO, DVec3::X, v(1.0, 1.0, 0.0)]).unwrap();
    assert_eq!(polyline.shape_type(), ShapeType::Wire);
    assert!(!polyline.is_closed());
    assert_close(polyline.length().unwrap(), 2.0, 1e-9);
    err_contains(Shape::polyline(&[DVec3::ZERO]), "at least 2 points");
    err_contains(Shape::polyline(&[DVec3::ZERO, DVec3::ZERO]), "distinct");

    let triangle = Shape::polygon(&[DVec3::ZERO, DVec3::X, DVec3::Y]).unwrap();
    assert!(triangle.is_closed());
    assert_eq!(triangle.edges().len(), 3);
    let explicit = Shape::polygon(&[DVec3::ZERO, DVec3::X, DVec3::Y, DVec3::ZERO]).unwrap();
    assert_eq!(explicit.edges().len(), 3);
    err_contains(Shape::polygon(&[DVec3::ZERO, DVec3::X]), "at least 3 distinct points");

    let plane = Plane::named("YZ").unwrap();
    let on_plane =
        Shape::polygon_on(&plane, &[glam::DVec2::ZERO, glam::DVec2::X, glam::DVec2::Y]).unwrap();
    assert_vec_close(on_plane.vertices().get(1).unwrap().point().unwrap(), DVec3::Y, 1e-12);

    let rect = Shape::rect_on(&Plane::xy(), 4.0, 2.0).unwrap();
    assert_close(rect.length().unwrap(), 12.0, 1e-9);
    assert_close(Shape::face_from(&rect).unwrap().area().unwrap(), 8.0, 1e-9);
    err_contains(Shape::rect_on(&Plane::xy(), 0.0, 1.0), "rectangle width");
    err_contains(Shape::rect_on(&Plane::xy(), 1.0, -1.0), "rectangle height");
}

#[test]
fn wires_faces_and_compounds() {
    let a = Shape::line(DVec3::ZERO, DVec3::X).unwrap();
    let b = Shape::line(DVec3::X, v(1.0, 1.0, 0.0)).unwrap();
    let c = Shape::line(v(1.0, 1.0, 0.0), DVec3::ZERO).unwrap();
    let open = Shape::wire_from(&[a.clone(), b.clone()]).unwrap();
    let closed = Shape::wire_from(&[open, c]).unwrap();
    assert!(closed.is_closed());
    assert_close(Shape::face_from(&closed).unwrap().area().unwrap(), 0.5, 1e-9);

    let far = Shape::line(v(5.0, 5.0, 5.0), v(6.0, 5.0, 5.0)).unwrap();
    err_contains(Shape::wire_from(&[a.clone(), far]), "do not form a connected wire");
    err_contains(Shape::wire_from(&[]), "at least one edge");
    let solid = Shape::cube(1.0).unwrap();
    assert!(matches!(
        err(Shape::wire_from(std::slice::from_ref(&solid))),
        Error::WrongShapeType { expected: "edge or wire", actual: "solid" }
    ));

    // Faces from faces, closed edges and closed wires; open and non-planar wires fail.
    let face = solid.faces().first().unwrap();
    assert!(Shape::face_from(&face).unwrap().is_same(&face));
    let disk = Shape::face_from(&Shape::circle_edge(DVec3::ZERO, DVec3::Z, 1.0).unwrap()).unwrap();
    assert_close(disk.area().unwrap(), PI, 1e-9);
    err_contains(Shape::face_from(&Shape::wire_from(&[a, b]).unwrap()), "closed wire");
    // An outline that runs back across itself (a figure eight) bounds no face.
    let crossed = Shape::polygon(&[
        v(0.0, 0.0, 0.0),
        v(10.0, 10.0, 0.0),
        v(10.0, 0.0, 0.0),
        v(0.0, 10.0, 0.0),
    ])
    .unwrap();
    err_contains(Shape::face_from(&crossed), "crosses or touches itself");
    let skew = Shape::polygon(&[DVec3::ZERO, DVec3::X, v(1.0, 1.0, 1.0), DVec3::Y]).unwrap();
    err_contains(Shape::face_from(&skew), "not planar");
    err_contains(Shape::face_from(&solid), "expected wire or face, got solid");

    let outer = Shape::rect_on(&Plane::xy(), 4.0, 4.0).unwrap();
    let hole = Shape::rect_on(&Plane::xy(), 2.0, 2.0).unwrap();
    let with_hole = Shape::face_with_holes(&outer, &[hole]).unwrap();
    assert_eq!(with_hole.shape_type(), ShapeType::Face);
    assert_close(with_hole.area().unwrap(), 12.0, 1e-9);
    assert_eq!(with_hole.wires().len(), 2);
    assert_close(with_hole.outer_wire().unwrap().length().unwrap(), 16.0, 1e-9);
    // Two holes still give a single face.
    let left = Shape::rect_on(&Plane::xy().translated(v(-1.0, 0.0, 0.0)), 0.5, 0.5).unwrap();
    let right = Shape::rect_on(&Plane::xy().translated(v(1.0, 0.0, 0.0)), 0.5, 0.5).unwrap();
    let two_holes = Shape::face_with_holes(&outer, &[left, right]).unwrap();
    assert_close(two_holes.area().unwrap(), 15.5, 1e-9);
    // A "hole" that splits the face would leave several faces: that is an error.
    let splitter = Shape::rect_on(&Plane::xy(), 1.0, 10.0).unwrap();
    err_contains(Shape::face_with_holes(&outer, &[splitter]), "the holes leave 2 faces");

    let compound = Shape::compound(&[solid.clone(), Shape::sphere(1.0).unwrap()]).unwrap();
    assert_eq!(compound.shape_type(), ShapeType::Compound);
    assert_eq!(compound.children(), 2);
    let empty = Shape::empty().unwrap();
    assert_eq!(empty.children(), 0);
    err_contains(empty.bounding_box(), "empty shape has no bounding box");
    err_contains(empty.center(), "empty shape has no center");
}
