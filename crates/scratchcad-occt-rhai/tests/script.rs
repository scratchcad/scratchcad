//! Every function registered with Rhai, exercised through real scripts.

mod common;

use common::{assert_close, assert_vec_close, temp_dir, v};
use scratchcad_occt_rhai::{
    engine, error_kind, eval, eval_shape,
    rhai::{Array, Dynamic, Engine, Scope, INT},
    BoundingBox, DVec3, ErrorKind, Mesh, Plane, Selection, Shape, ShapeType, Sketch,
};
use std::f64::consts::PI;

#[track_caller]
fn run<T: Clone + 'static>(script: &str) -> T {
    match engine().eval::<T>(script) {
        Ok(value) => value,
        Err(e) => panic!("script failed: {script}\n{e}"),
    }
}

#[track_caller]
fn fails(script: &str, needle: &str) {
    match engine().eval::<Dynamic>(script) {
        Ok(value) => panic!("script should fail: {script}\ngot {value:?}"),
        Err(e) => {
            let message = e.to_string();
            assert!(message.contains(needle), "{script}\n{message:?} does not contain {needle:?}");
        },
    }
}

fn f(script: &str) -> f64 {
    run::<f64>(script)
}

#[test]
fn vectors() {
    assert_eq!(run::<DVec3>("vec3(1, 2.5, 3)"), v(1.0, 2.5, 3.0));
    assert_eq!(run::<DVec3>("vec3(1, 2)"), v(1.0, 2.0, 0.0));
    assert_eq!(run::<DVec3>("vec3([1, 2, 3])"), v(1.0, 2.0, 3.0));
    assert_eq!(run::<DVec3>("vec3([1, 2])"), v(1.0, 2.0, 0.0));
    assert_eq!(run::<DVec3>("vec3(\"-Y\")"), v(0.0, -1.0, 0.0));
    assert_eq!(run::<DVec3>("vec3(vec3(1, 1, 1))"), DVec3::ONE);
    assert_eq!(f("let p = vec3(1, 2, 3); p.x + p.y * 10 + p.z * 100"), 321.0);
    assert_eq!(
        run::<DVec3>("let p = vec3(0, 0, 0); p.x = 1; p.y = 2.5; p.z = -1; p"),
        v(1.0, 2.5, -1.0)
    );
    fails("let p = vec3(0, 0, 0); p.x = \"a\"; p", "x must be a number");
    fails("let p = vec3(0, 0, 0); p.y = (); p", "y must be a number");
    fails("let p = vec3(0, 0, 0); p.z = true; p", "z must be a number");

    assert_eq!(run::<DVec3>("vec3(1, 2, 3) + vec3(1, 1, 1)"), v(2.0, 3.0, 4.0));
    assert_eq!(run::<DVec3>("vec3(1, 2, 3) - vec3(1, 1, 1)"), v(0.0, 1.0, 2.0));
    assert_eq!(run::<DVec3>("-vec3(1, 2, 3)"), v(-1.0, -2.0, -3.0));
    assert_eq!(run::<DVec3>("vec3(1, 2, 3) * 2"), v(2.0, 4.0, 6.0));
    assert_eq!(run::<DVec3>("vec3(1, 2, 3) * 0.5"), v(0.5, 1.0, 1.5));
    assert_eq!(run::<DVec3>("2 * vec3(1, 2, 3)"), v(2.0, 4.0, 6.0));
    assert_eq!(run::<DVec3>("0.5 * vec3(1, 2, 3)"), v(0.5, 1.0, 1.5));
    assert_eq!(run::<DVec3>("vec3(2, 4, 6) / 2"), v(1.0, 2.0, 3.0));
    fails("vec3(1, 1, 1) / 0", "division of a vector by zero");
    assert!(run::<bool>("vec3(1, 2, 3) == vec3(1, 2, 3)"));
    assert!(run::<bool>("vec3(1, 2, 3) != vec3(1, 2, 4)"));
    assert_eq!(f("vec3(1, 2, 3).dot(vec3(1, 1, 1))"), 6.0);
    assert_eq!(run::<DVec3>("vec3(1, 0, 0).cross(vec3(0, 1, 0))"), DVec3::Z);
    assert_eq!(f("vec3(3, 4, 0).length()"), 5.0);
    assert_eq!(f("vec3(0, 0, 0).distance(vec3(0, 3, 4))"), 5.0);
    assert_eq!(run::<DVec3>("vec3(0, 0, 9).normalize()"), DVec3::Z);
    fails("vec3(0, 0, 0).normalize()", "zero-length");
    assert_eq!(run::<Array>("vec3(1, 2, 3).to_array()").len(), 3);
    assert_eq!(run::<String>("vec3(1, 2.5, 3).to_string()"), "vec3(1, 2.5, 3)");
    assert_eq!(run::<String>("vec3(1, 2, 3).to_debug()"), "vec3(1, 2, 3)");
    assert_eq!(run::<String>("`${vec3(1, 2, 3)}`"), "vec3(1, 2, 3)");

    fails("vec3(\"a\", 1, 2)", "x must be a number");
    fails("vec3(1, \"b\")", "y must be a number");
    fails("vec3(1, 2, ())", "z must be a number");
    fails("vec3([1, 2, 3, 4])", "must have 2 or 3 components");
    fails("vec3([1, \"x\", 3])", "must be a number");
    fails("vec3(42)", "must be a vec3 or an array of numbers");
    fails("vec3(\"W\")", "unknown direction");
}

#[test]
fn planes() {
    let plane = run::<Plane>("plane(\"XZ\")");
    assert_eq!(plane, Plane::named("XZ").unwrap());
    let custom = run::<Plane>("plane([0, 0, 5], \"Z\")");
    assert_eq!(custom.origin(), v(0.0, 0.0, 5.0));
    let with_x = run::<Plane>("plane([0, 0, 0], [0, 0, 1], [0, 1, 0])");
    assert_eq!(with_x.x_dir(), DVec3::Y);
    assert_eq!(run::<DVec3>("plane(\"XY\").origin"), DVec3::ZERO);
    assert_eq!(run::<DVec3>("plane(\"XY\").normal"), DVec3::Z);
    assert_eq!(run::<DVec3>("plane(\"XY\").x_dir"), DVec3::X);
    assert_eq!(run::<DVec3>("plane(\"XY\").y_dir"), DVec3::Y);
    assert_eq!(run::<DVec3>("plane(\"XY\").offset(2).origin"), v(0.0, 0.0, 2.0));
    assert_eq!(run::<DVec3>("plane(\"XY\").translate([1, 2, 3]).origin"), v(1.0, 2.0, 3.0));
    assert_eq!(run::<DVec3>("plane(\"XZ\").to_world(1, 2)"), v(1.0, 0.0, 2.0));
    assert_eq!(run::<DVec3>("plane(\"XZ\").to_local([1, 5, 2])"), v(1.0, 2.0, 0.0));
    assert!(run::<String>("plane(\"XY\").to_string()").starts_with("Plane(origin: (0, 0, 0)"));
    assert!(run::<String>("plane(\"XY\").to_debug()").starts_with("Plane("));
    fails("plane(\"QQ\")", "unknown plane");
    fails("plane([0, 0, 0], [0, 0, 0])", "zero-length");
    fails("plane([0, 0, 0], \"Z\", \"Z\")", "parallel to its normal");
    fails("plane(\"XY\").offset(\"a\")", "offset must be a number");
    fails("circle(5, 3)", "expected a Plane or a plane name");
}

#[test]
fn solid_constructors() {
    assert_close(f("box(1, 2, 3).volume()"), 6.0, 1e-9);
    assert_close(f("box_centered(2, 2, 2).bounding_box().min.x"), -1.0, 1e-9);
    assert_close(f("box_from_corners([0, 0, 0], [1, 2, 3]).volume()"), 6.0, 1e-9);
    assert_close(f("cube(2).volume()"), 8.0, 1e-9);
    assert_close(f("cylinder(1, 2).volume()"), 2.0 * PI, 1e-6);
    assert_close(f("cylinder([0, 0, 0], \"X\", 1, 2).bounding_box().xlen"), 2.0, 1e-6);
    assert_close(f("sphere(1).volume()"), 4.0 / 3.0 * PI, 1e-6);
    assert_close(f("sphere([1, 0, 0], 1).center().x"), 1.0, 1e-9);
    assert_close(f("cone(1, 0, 3).volume()"), PI, 1e-6);
    assert_close(f("torus(3, 1).volume()"), 6.0 * PI * PI, 1e-6);
    fails("box(1, 2, \"x\")", "z size must be a number");
    fails("box_centered(\"x\", 1, 1)", "x size must be a number");
    fails("box(0, 1, 1)", "box x size must be positive");
    fails("cube(0)", "must be positive");
    assert_close(f("cube(-1).bounding_box().min.x"), -1.0, 1e-9);
    fails("sphere(0)", "sphere radius");
    fails("cone(1, 1, 1)", "radii must differ");
    fails("torus(1, \"r\")", "minor radius must be a number");
    fails("box_centered(0, 1, 1)", "box x size must be positive");
    fails("box_from_corners([0, 0, 0], [0, 1, 1])", "box x size must be positive");
    fails("cylinder([0, 0, 0], \"Z\", 0, 1)", "cylinder radius");
    fails("sphere([0, 0, 0], -1)", "sphere radius");
}

#[test]
fn curve_and_profile_constructors() {
    assert_eq!(run::<DVec3>("vertex([1, 2, 3]).point()"), v(1.0, 2.0, 3.0));
    assert_close(f("line([0, 0, 0], [3, 4, 0]).length()"), 5.0, 1e-9);
    assert_close(f("arc([1, 0, 0], [0, 1, 0], [-1, 0, 0]).length()"), PI, 1e-9);
    assert_close(f("circle(2).length()"), 4.0 * PI, 1e-9);
    assert_close(f("circle(plane(\"XZ\"), 1).normal().y.abs()"), 1.0, 1e-9);
    assert_close(f("circle(\"YZ\", 1).normal().x.abs()"), 1.0, 1e-9);
    assert_close(f("circle([0, 0, 5], \"Z\", 1).center().z"), 5.0, 1e-9);
    assert_close(f("rect(2, 3).length()"), 10.0, 1e-9);
    assert_close(f("rect(\"XZ\", 2, 3).to_face().area()"), 6.0, 1e-9);
    assert_close(f("polygon([[0, 0], [1, 0], [0, 1]]).to_face().area()"), 0.5, 1e-9);
    assert_close(f("polygon(\"YZ\", [[0, 0], [2, 0], [0, 2]]).to_face().area()"), 2.0, 1e-9);
    assert_close(
        f("polygon(\"YZ\", [vec3(0, 0, 0), vec3(2, 0, 0), vec3(0, 2, 0)]).to_face().area()"),
        2.0,
        1e-9,
    );
    assert_close(f("polyline([[0, 0, 0], [1, 0, 0], [1, 1, 0]]).length()"), 2.0, 1e-9);
    assert!(!run::<bool>("spline([[0, 0, 0], [1, 1, 0], [2, 0, 0]]).is_closed()"));
    assert!(run::<bool>("spline([[0, 0, 0], [1, 1, 0], [2, 0, 0]], true).is_closed()"));
    assert_eq!(run::<String>("bezier([[0, 0, 0], [1, 2, 0], [2, 0, 0]]).geom_type()"), "bezier");
    assert!(run::<bool>("wire([line([0,0,0], [1,0,0]), line([1,0,0], [0,1,0]), line([0,1,0], [0,0,0])]).is_closed()"));
    assert_close(f("face(rect(4, 4)).area()"), 16.0, 1e-9);
    assert_close(f("face(rect(4, 4), [rect(2, 2)]).area()"), 12.0, 1e-9);
    assert_close(f("face(rect(4, 4), rect(2, 2)).area()"), 12.0, 1e-9);
    assert_eq!(run::<INT>("compound([box(1, 1, 1), sphere(1)]).children()"), 2);
    assert_close(
        f("fuse_all([box(1, 1, 1), box(1, 1, 1).translate([1, 0, 0])]).volume()"),
        2.0,
        1e-9,
    );
    assert_close(
        f("loft([circle(1), circle([0, 0, 2], \"Z\", 2)]).volume()"),
        14.0 * PI / 3.0,
        1e-4,
    );
    assert_eq!(
        run::<String>("loft([circle(1), circle([0, 0, 2], \"Z\", 2)], false).shape_type()"),
        "shell"
    );
    let ruled = "ruled_loft([circle(1), circle([0, 0, 2], \"Z\", 2), circle([0, 0, 4], \"Z\", 1)])";
    assert_close(f(&format!("{ruled}.volume()")), 28.0 * PI / 3.0, 1e-4);
    assert_eq!(
        run::<String>("ruled_loft([circle(1), circle([0, 0, 2], \"Z\", 2)], false).shape_type()"),
        "shell"
    );

    fails("polygon([[0, 0], [1, 0]])", "at least 3 distinct points");
    fails("polygon([1, 2, 3])", "polygon point must be a vec3");
    fails("polygon(\"XY\", [[0, 0, 0, 0]])", "must have 2 or 3 components");
    fails("wire([])", "at least one edge");
    fails("wire([[box(1, 1, 1)]])", "nested arrays");
    fails("wire(42)", "expected shapes, got i64");
    fails("compound([1])", "expected shapes");
    fails("line([0, 0, 0], [0, 0, 0])", "two distinct finite points");
}

#[test]
fn shape_queries() {
    assert_eq!(run::<String>("box(1, 1, 1).shape_type()"), "solid");
    assert!(run::<bool>("box(1, 1, 1).is_valid()"));
    assert!(run::<bool>("box(1, 1, 1).is_closed()"));
    assert!(run::<bool>("let b = box(1, 1, 1); b.is_same(b)"));
    assert!(run::<bool>("let b = box(1, 1, 1); b == b"));
    assert!(run::<bool>("box(1, 1, 1) != box(1, 1, 1)"));
    assert_eq!(
        run::<String>("box(1, 1, 1).to_string()"),
        "Shape(solid, 6 faces, 12 edges, 8 vertices)"
    );
    assert_eq!(
        run::<String>("box(1, 1, 1).to_debug()"),
        "Shape(solid, 6 faces, 12 edges, 8 vertices)"
    );
    assert_close(f("box(1, 2, 3).area()"), 22.0, 1e-9);
    assert_close(f("box(1, 2, 3).length()"), 24.0, 1e-9);
    assert_eq!(run::<DVec3>("box(2, 2, 2).center()"), DVec3::ONE);
    let bbox = run::<BoundingBox>("box(1, 2, 3).bounding_box()");
    assert_eq!(bbox.max, v(1.0, 2.0, 3.0));
    assert_close(f("box(1, 1, 1).distance(box(1, 1, 1).translate(3, 0, 0))"), 2.0, 1e-9);
    let closest = run::<Array>("box(1, 1, 1).closest_points(vertex([3, 0.5, 0.5]))");
    assert_eq!(closest[1].clone().cast::<DVec3>(), v(3.0, 0.5, 0.5));
    assert_eq!(run::<INT>("box(1, 1, 1).faces().len()"), 6);
    assert_eq!(run::<INT>("box(1, 1, 1).edges().len()"), 12);
    assert_eq!(run::<INT>("box(1, 1, 1).vertices().len()"), 8);
    assert_eq!(run::<INT>("box(1, 1, 1).wires().len()"), 6);
    assert_eq!(run::<INT>("box(1, 1, 1).shells().len()"), 1);
    assert_eq!(run::<INT>("box(1, 1, 1).solids().len()"), 1);
    assert_eq!(run::<INT>("box(1, 1, 1).faces(\"#Z\").len()"), 4);
    assert_eq!(run::<INT>("box(1, 1, 1).edges(\"|Z\").len()"), 4);
    assert_eq!(run::<INT>("box(1, 1, 1).vertices(\">Z\").len()"), 4);
    assert_close(f("box(1, 1, 3).face(\">Z\").center().z"), 3.0, 1e-9);
    assert_close(f("box(1, 1, 3).edge(\">Z and |X\").center().z"), 3.0, 1e-9);
    assert_eq!(run::<DVec3>("box(1, 1, 1).vertex(\">(1, 1, 1)\").point()"), DVec3::ONE);
    assert_close(f("box(1, 1, 3).top_face().center().z"), 3.0, 1e-9);
    assert_close(f("box(1, 1, 3).bottom_face().center().z"), 0.0, 1e-9);
    assert_eq!(run::<INT>("compound([box(1, 1, 1)]).children()"), 1);
    fails("box(1, 1, 1).face(\"%CYLINDER\")", "selection is empty");
    fails("box(1, 1, 1).faces(\"??\")", "invalid selector");

    assert_eq!(run::<DVec3>("vertex([1, 2, 3]).point()"), v(1.0, 2.0, 3.0));
    assert_eq!(run::<DVec3>("line([0, 0, 0], [2, 0, 0]).start_point()"), DVec3::ZERO);
    assert_eq!(run::<DVec3>("line([0, 0, 0], [2, 0, 0]).end_point()"), v(2.0, 0.0, 0.0));
    assert_eq!(run::<DVec3>("line([0, 0, 0], [2, 0, 0]).point_at(0.5)"), DVec3::X);
    assert_eq!(run::<DVec3>("line([0, 0, 0], [2, 0, 0]).tangent_at(1)"), DVec3::X);
    assert_close(f("circle(3).edges().first().radius()"), 3.0, 1e-9);
    assert_eq!(run::<String>("line([0, 0, 0], [1, 0, 0]).geom_type()"), "line");
    assert_eq!(run::<DVec3>("box(1, 1, 1).top_face().normal()"), DVec3::Z);
    assert_eq!(run::<DVec3>("box(1, 1, 1).top_face().plane().normal"), DVec3::Z);
    assert_close(f("face(rect(4, 4), [rect(2, 2)]).outer_wire().length()"), 16.0, 1e-9);
    fails("box(1, 1, 1).point()", "expected vertex, got solid");
    fails("line([0, 0, 0], [1, 0, 0]).point_at(\"a\")", "parameter must be a number");
    fails("line([0, 0, 0], [1, 0, 0]).tangent_at(2)", "within [0, 1]");
    fails("line([0, 0, 0], [1, 0, 0]).radius()", "only circular edges");
}

#[test]
fn booleans_and_operators() {
    let base = "let a = box(2, 2, 2); let b = box(2, 2, 2).translate([1, 1, 1]);";
    for (op, expected) in [
        ("a.fuse(b)", 15.0),
        ("a.union(b)", 15.0),
        ("a + b", 15.0),
        ("a.cut(b)", 7.0),
        ("a - b", 7.0),
        ("a.common(b)", 1.0),
        ("a.intersect(b)", 1.0),
        ("a & b", 1.0),
    ] {
        assert_close(f(&format!("{base} ({op}).volume()")), expected, 1e-6);
    }
    assert_close(f(&format!("{base} let c = a; c += b; c.volume()")), 15.0, 1e-6);
    assert_eq!(run::<INT>(&format!("{base} a.section(b).edges().len()")), 6);
}

#[test]
fn transforms() {
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).translate([1, 0, 0]).center()"),
        v(2.0, 1.0, 1.0),
        1e-9,
    );
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).translate(1, 2, 3).center()"),
        v(2.0, 3.0, 4.0),
        1e-9,
    );
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).rotate(\"Z\", 90).center()"),
        v(-1.0, 1.0, 1.0),
        1e-9,
    );
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).rotate([1, 1, 0], \"Z\", 180).center()"),
        DVec3::ONE,
        1e-9,
    );
    assert_vec_close(run::<DVec3>("box(2, 2, 2).rotate_x(90).center()"), v(1.0, -1.0, 1.0), 1e-9);
    assert_vec_close(run::<DVec3>("box(2, 2, 2).rotate_y(90).center()"), v(1.0, 1.0, -1.0), 1e-9);
    assert_vec_close(run::<DVec3>("box(2, 2, 2).rotate_z(90).center()"), v(-1.0, 1.0, 1.0), 1e-9);
    assert_close(f("box(1, 1, 1).scale(2).volume()"), 8.0, 1e-9);
    assert_vec_close(run::<DVec3>("box(2, 2, 2).scale([1, 1, 1], 0.5).center()"), DVec3::ONE, 1e-9);
    // Mirroring through named planes, Plane values, directions and explicit planes.
    assert_vec_close(run::<DVec3>("box(2, 2, 2).mirror(\"XY\").center()"), v(1.0, 1.0, -1.0), 1e-9);
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).mirror(plane(\"YZ\")).center()"),
        v(-1.0, 1.0, 1.0),
        1e-9,
    );
    assert_vec_close(run::<DVec3>("box(2, 2, 2).mirror(\"Y\").center()"), v(1.0, -1.0, 1.0), 1e-9);
    assert_vec_close(run::<DVec3>("box(2, 2, 2).mirror(\"-Z\").center()"), v(1.0, 1.0, -1.0), 1e-9);
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).mirror([1, 0, 0]).center()"),
        v(-1.0, 1.0, 1.0),
        1e-9,
    );
    assert_vec_close(
        run::<DVec3>("box(2, 2, 2).mirror([0, 0, 5], \"Z\").center()"),
        v(1.0, 1.0, 9.0),
        1e-9,
    );
    fails(
        "box(1, 1, 1).translate(\"up\")",
        "translation must be a vec3 or an array of numbers, got string",
    );
    fails("box(1, 1, 1).translate([1, 2, 3, 4])", "translation must have 2 or 3 components");
    fails("box(1, 1, 1).rotate(\"Z\", \"ninety\")", "angle must be a number");
    fails("box(1, 1, 1).scale(0)", "must not be zero");
    fails("box(1, 1, 1).scale([0, 0, 0], 0)", "must not be zero");
    fails("box(1, 1, 1).rotate([0, 0, 0], [0, 0, 0], 90)", "direction must be a non-zero vector");
    fails("box(1, 1, 1).rotate([0, 0, 0], \"Z\", \"x\")", "angle must be a number");
    fails("box(1, 1, 1).mirror([0, 0, 0], [0, 0, 0])", "direction must be a non-zero vector");
    fails("box(1, 1, 1).mirror(42)", "mirror normal must be a vec3");
    fails("box(1, 1, 1).mirror(\"up\")", "unknown direction");
}

#[test]
fn features() {
    assert_close(f("rect(2, 3).extrude(4).volume()"), 24.0, 1e-9);
    assert_close(f("rect(2, 3).extrude(4.5).volume()"), 27.0, 1e-9);
    assert_close(f("rect(2, 3).extrude([0, 0, -1]).bounding_box().min.z"), -1.0, 1e-9);
    assert_close(f("rect(2, 3).extrude(\"Z\").volume()"), 6.0, 1e-9);
    assert_close(
        f("rect(\"XZ\", 2, 2).translate([3, 0, 0]).revolve(\"Z\", 360).volume()"),
        24.0 * PI,
        1e-6,
    );
    assert_close(
        f("rect(\"XZ\", 2, 2).revolve([3, 0, 0], \"Z\", 180).volume()"),
        2.0 * PI * 2.0 * 3.0 / 2.0 * 2.0,
        1e-6,
    );
    assert_close(f("circle(1).sweep(line([0, 0, 0], [0, 0, 10])).volume()"), 10.0 * PI, 1e-6);
    assert!(f("box(10, 10, 10).fillet(1).volume()") < 1000.0);
    assert_close(f("box(10, 10, 10).fillet(2, \"|Z\").volume()"), 1000.0 - 40.0 * (4.0 - PI), 1e-3);
    assert_close(
        f("let b = box(10, 10, 10); b.fillet(2, b.edges(\"|Z\")).volume()"),
        1000.0 - 40.0 * (4.0 - PI),
        1e-3,
    );
    assert_close(
        f("let b = box(10, 10, 10); b.fillet(2, b.edges(\"|Z\").first()).volume()"),
        1000.0 - 10.0 * (4.0 - PI),
        1e-3,
    );
    assert_close(
        f("let b = box(10, 10, 10); b.fillet(2, b.edges(\"|Z\").to_array()).volume()"),
        1000.0 - 40.0 * (4.0 - PI),
        1e-3,
    );
    assert!(f("box(10, 10, 10).chamfer(1).volume()") < 1000.0);
    assert_close(f("box(10, 10, 10).chamfer(1, \">Z and |X\").volume()"), 990.0, 1e-6);
    assert_close(f("box(10, 10, 10).shell(-1, \">Z\").volume()"), 424.0, 1e-6);
    assert_close(f("box(10, 10, 10).shell(-1).volume()"), 1000.0 - 512.0, 1e-6);
    assert_close(f("rect(4, 4).offset(1).length()"), 16.0 + 2.0 * PI, 1e-6);
    assert_eq!(
        run::<INT>("(box(1, 1, 1) + box(1, 1, 1).translate(1, 0, 0)).clean().faces().len()"),
        6
    );
    assert_eq!(run::<String>("rect(1, 1).to_face().shape_type()"), "face");
    fails("box(1, 1, 1).fillet(\"big\")", "fillet radius must be a number");
    fails("box(1, 1, 1).fillet(0.1, \"%CIRCLE\")", "fillet needs at least one edge");
    fails("box(1, 1, 1).fillet(0.1, 5)", "expected shapes");
    fails("box(1, 1, 1).chamfer(0.1, box(1, 1, 1).faces())", "expected edge, got face");
    fails("box(1, 1, 1).shell(0, \">Z\")", "must not be zero");
    fails("line([0, 0, 0], [1, 0, 0]).extrude(1)", "expected face, got edge");
    fails("box(1, 1, 1).revolve(\"Z\", 0)", "(0, 360]");
    fails("rect(1, 1).revolve([5, 0, 0], \"Z\", 0)", "(0, 360]");
    fails("circle(1).sweep(box(1, 1, 1))", "expected edge or wire");
    fails("loft([circle(1)])", "at least 2 sections");
    fails("loft([circle(1)], true)", "at least 2 sections");
    fails("rect(1, 1).offset(\"x\")", "offset must be a number");
}

#[test]
fn selections() {
    let base = "let faces = box(10, 10, 10).faces();";
    let run_sel = |script: &str| run::<Selection>(&format!("{base} {script}"));
    let count = |script: &str| run::<INT>(&format!("{base} {script}"));
    assert_eq!(count("faces.len()"), 6);
    assert!(!run::<bool>(&format!("{base} faces.is_empty()")));
    assert!(run::<bool>(&format!("{base} faces.select(\"%CYLINDER\").is_empty()")));
    assert_close(f(&format!("{base} faces[0].area()")), 100.0, 1e-9);
    assert_close(f(&format!("{base} faces[-1].area()")), 100.0, 1e-9);
    assert_close(f(&format!("{base} faces.get(1).area()")), 100.0, 1e-9);
    assert!(run::<bool>(&format!("{base} faces.first() == faces[0]")));
    assert!(run::<bool>(&format!("{base} faces.last() == faces[5]")));
    assert_close(f(&format!("{base} faces.select(\">Z\").single().center().z")), 10.0, 1e-9);
    assert_eq!(run_sel("faces.filter(|f| f.center().z > 4)").len(), 5);
    let sorted = run_sel("faces.sort_by(|f| f.center().z)");
    assert_close(sorted.first().unwrap().center().unwrap().z, 0.0, 1e-9);
    assert_close(sorted.last().unwrap().center().unwrap().z, 10.0, 1e-9);
    assert_eq!(run_sel("faces.sort_by(|f| 1)").len(), 6);
    for (call, expected) in [
        ("top", 10.0),
        ("bottom", 0.0),
        ("right", 5.0),
        ("left", 5.0),
        ("back", 5.0),
        ("front", 5.0),
    ] {
        assert_close(f(&format!("{base} faces.{call}().single().center().z")), expected, 1e-9);
    }
    assert_close(f(&format!("{base} faces.farthest(\"X\").single().center().x")), 10.0, 1e-9);
    assert_close(f(&format!("{base} faces.nearest([1, 0, 0]).single().center().x")), 0.0, 1e-9);
    assert_eq!(count("faces.parallel_to(\"Z\").len()"), 2);
    assert_eq!(count("faces.perpendicular_to(\"Z\").len()"), 4);
    assert_eq!(count("faces.facing(\"-Z\").len()"), 1);
    assert_eq!(count("faces.of_type(\"plane\").len()"), 6);
    assert_eq!(count("faces.top().union(faces.bottom()).len()"), 2);
    assert_eq!(count("(faces.top() + faces.bottom()).len()"), 2);
    assert_eq!(count("faces.intersect(faces.top()).len()"), 1);
    assert_eq!(count("faces.subtract(faces.top()).len()"), 5);
    assert_eq!(count("(faces - faces.top()).len()"), 5);
    assert_eq!(count("faces.to_array().len()"), 6);
    assert_eq!(count("faces.compound().faces().len()"), 6);
    assert_eq!(count("selection([box(1,1,1), sphere(1)]).len()"), 2);
    assert_eq!(count("let n = 0; for face in faces { n += 1; } n"), 6);
    assert_eq!(run::<String>(&format!("{base} faces.to_string()")), "Selection([6 face])");
    assert_eq!(run::<String>(&format!("{base} faces.to_debug()")), "Selection([6 face])");

    fails(&format!("{base} faces[6]"), "index 6 out of range");
    fails(&format!("{base} faces.get(-7)"), "index -7 out of range");
    fails(&format!("{base} faces.select(\"%LINE\").first()"), "selection is empty");
    fails(&format!("{base} faces.select(\"%LINE\").last()"), "selection is empty");
    fails(&format!("{base} faces.single()"), "found 6");
    fails(&format!("{base} faces.filter(|f| 1)"), "filter function must return a bool");
    fails(&format!("{base} faces.filter(|f| f.radius() > 0)"), "expected edge, got face");
    fails(&format!("{base} faces.sort_by(|f| \"key\")"), "sort key must be a number");
    fails(&format!("{base} faces.sort_by(|f| f.point())"), "expected vertex");
    fails(&format!("{base} faces.farthest([0, 0, 0])"), "zero-length");
}

#[test]
fn sketches() {
    let profile = "sketch().line_to(2, 0).line_to(2, 2).line_to(0, 2)";
    assert_close(f(&format!("{profile}.face().area()")), 4.0, 1e-9);
    assert!(run::<bool>(&format!("{profile}.close().is_closed()")));
    assert!(!run::<bool>(&format!("{profile}.wire().is_closed()")));
    assert_eq!(run::<DVec3>(&format!("{profile}.position()")), v(0.0, 2.0, 0.0));
    assert_eq!(run::<INT>(&format!("{profile}.segment_count()")), 3);
    assert_eq!(run::<String>(&format!("{profile}.to_string()")), "Sketch(3 segments, at (0, 2))");
    assert_eq!(run::<String>(&format!("{profile}.to_debug()")), "Sketch(3 segments, at (0, 2))");
    assert_eq!(run::<Plane>("sketch(\"XZ\").plane()"), Plane::named("XZ").unwrap());
    assert_eq!(run::<Plane>("sketch(plane(\"YZ\")).plane()"), Plane::named("YZ").unwrap());
    let all = "sketch().move_to(1, 1).line(1, 0).hline(1).vline(1).hline_to(1).vline_to(3).polar_line(1, 180).arc_to(-1, 2, 0, 1)";
    assert_eq!(run::<Sketch>(all).segment_count(), 7);
    assert_close(
        f(&format!("{all}.close().length()")),
        run::<Shape>(&format!("{all}.close()")).length().unwrap(),
        1e-12,
    );
    fails("sketch().line_to(\"a\", 1)", "first argument must be a number");
    fails("sketch().line(1, \"b\")", "second argument must be a number");
    fails("sketch().hline(\"c\")", "argument must be a number");
    fails("sketch().arc_to(1, \"y\", 2, 0)", "y must be a number");
    fails("sketch().line_to(1, 0).move_to(2, 2)", "move_to is only allowed before drawing");
    fails("sketch().face()", "at least 3 lines");
    fails("sketch(\"XX\")", "unknown plane");
}

#[test]
fn bounding_boxes_and_meshes() {
    let bbox = "box(1, 2, 3).translate(1, 1, 1).bounding_box()";
    assert_eq!(run::<DVec3>(&format!("{bbox}.min")), DVec3::ONE);
    assert_eq!(run::<DVec3>(&format!("{bbox}.max")), v(2.0, 3.0, 4.0));
    assert_eq!(run::<DVec3>(&format!("{bbox}.center")), v(1.5, 2.0, 2.5));
    assert_eq!(run::<DVec3>(&format!("{bbox}.size")), v(1.0, 2.0, 3.0));
    assert_eq!(f(&format!("{bbox}.xlen")), 1.0);
    assert_eq!(f(&format!("{bbox}.ylen")), 2.0);
    assert_eq!(f(&format!("{bbox}.zlen")), 3.0);
    assert!(run::<bool>(&format!("{bbox}.contains([1.5, 2, 2])")));
    assert!(!run::<bool>(&format!("{bbox}.contains([0, 0, 0])")));
    assert!(run::<String>(&format!("{bbox}.to_string()")).starts_with("BoundingBox("));
    assert!(run::<String>(&format!("{bbox}.to_debug()")).starts_with("BoundingBox("));
    fails(&format!("{bbox}.contains(1)"), "point must be a vec3");

    let mesh = run::<Mesh>("box(1, 1, 1).mesh(0.1)");
    assert_eq!(mesh.triangle_count(), 12);
    assert_eq!(run::<INT>("box(1, 1, 1).mesh(0.1).triangle_count"), 12);
    assert_eq!(run::<INT>("box(1, 1, 1).mesh(0.1).vertex_count"), 24);
    assert_eq!(run::<Array>("box(1, 1, 1).mesh(0.1).vertices").len(), 24);
    assert_eq!(run::<Array>("box(1, 1, 1).mesh(0.1).normals").len(), 24);
    assert_eq!(run::<Array>("box(1, 1, 1).mesh(0.1).indices").len(), 36);
    assert_close(f("box(1, 1, 1).mesh(0.1).area()"), 6.0, 1e-9);
    assert_eq!(
        run::<String>("box(1, 1, 1).mesh(0.1).to_string()"),
        "Mesh(24 vertices, 12 triangles)"
    );
    assert_eq!(
        run::<String>("box(1, 1, 1).mesh(0.1).to_debug()"),
        "Mesh(24 vertices, 12 triangles)"
    );
    fails("box(1, 1, 1).mesh(\"fine\")", "tolerance must be a number");
}

#[test]
fn hosts_read_and_write_files_for_scripts() {
    let dir = temp_dir();
    let input = dir.path().join("in.step");
    Shape::make_box(1.0, 2.0, 3.0).unwrap().write_step(&input).unwrap();

    let mut scope = Scope::new();
    scope.push("part", Shape::read_step(&input).unwrap());
    let result: Shape =
        engine().eval_with_scope(&mut scope, "part.translate([1, 0, 0]).fillet(0.1)").unwrap();
    let output = dir.path().join("out.brep");
    result.export(&output, 0.1).unwrap();
    let back = Shape::import(&output).unwrap();
    assert_close(back.bounding_box().unwrap().min.x, 1.0, 1e-6);
    assert!(back.volume().unwrap() < 6.0);
}

#[test]
fn errors_are_catchable_in_scripts() {
    // try/catch is a statement in Rhai; the catch variable holds the error message.
    let message =
        run::<String>(r#"let m = "no error"; try { box(0, 1, 1); } catch (err) { m = err; } m"#);
    assert!(message.contains("box x size must be positive"), "{message}");
    let recovered = run::<f64>(
        r#"let r = 0.0; try { r = box(1, 1, 1).fillet(50).volume(); } catch { r = -1.0; } r"#,
    );
    assert_eq!(recovered, -1.0);
}

#[test]
fn script_results_convert_to_shapes() {
    assert_eq!(eval_shape("box(1, 1, 1)").unwrap().shape_type(), ShapeType::Solid);
    assert_eq!(eval_shape("box(1, 1, 1).faces()").unwrap().faces().len(), 6);
    assert_eq!(
        eval_shape("[box(1, 1, 1), sphere(1).translate(5, 0, 0)]").unwrap().solids().len(),
        2
    );
    assert_eq!(
        eval_shape("sketch().line_to(1, 0).line_to(0, 1)").unwrap().shape_type(),
        ShapeType::Wire
    );
    let err = eval_shape("42").err().unwrap().to_string();
    assert!(err.contains("must evaluate to a shape, got i64"), "{err}");
    assert!(eval_shape("box(").is_err());
    assert_eq!(eval("1 + 1").unwrap().as_int().unwrap(), 2);
    let err = scratchcad_occt_rhai::to_shape(Dynamic::UNIT).err().unwrap().to_string();
    assert!(err.contains("got ()"), "{err}");
}

#[test]
fn engines_can_be_extended() {
    let mut engine = Engine::new();
    scratchcad_occt_rhai::register(&mut engine);
    engine.register_fn("double_box", |s: f64| Shape::make_box(2.0 * s, 2.0 * s, 2.0 * s).unwrap());
    let volume: f64 = engine.eval("double_box(1.0).volume()").unwrap();
    assert_close(volume, 8.0, 1e-9);
}

#[test]
fn occt_message_level_can_be_toggled() {
    scratchcad_occt_rhai::set_occt_messages(false);
    assert!(scratchcad_occt_rhai::ffi::message::Message_default_printer_count() >= 1);
    scratchcad_occt_rhai::set_occt_messages(true);
}

#[test]
fn scripts_cannot_touch_files() {
    let dir = temp_dir();
    let p = |name: &str| dir.path().join(name).to_string_lossy().replace('\\', "/");
    std::fs::write(dir.path().join("a.step"), Shape::cube(1.0).unwrap().to_step().unwrap())
        .unwrap();
    // Every file function earlier versions registered, and a few other likely names.
    let calls = [
        format!("load(\"{}\")", p("a.step")),
        format!("import_step(\"{}\")", p("a.step")),
        format!("import_iges(\"{}\")", p("a.igs")),
        format!("import_brep(\"{}\")", p("a.brep")),
        format!("read_step(\"{}\")", p("a.step")),
        format!("box(1, 1, 1).save(\"{}\")", p("b.step")),
        format!("box(1, 1, 1).export_step(\"{}\")", p("b.step")),
        format!("box(1, 1, 1).export_iges(\"{}\")", p("b.igs")),
        format!("box(1, 1, 1).export_brep(\"{}\")", p("b.brep")),
        format!("box(1, 1, 1).export_stl(\"{}\")", p("b.stl")),
        format!("box(1, 1, 1).export_stl(\"{}\", 0.1)", p("b.stl")),
        format!("box(1, 1, 1).write_step(\"{}\")", p("b.step")),
    ];
    // `engine()`, and an engine of the caller's own given everything through `register`.
    let mut own = Engine::new();
    scratchcad_occt_rhai::register(&mut own);
    for engine in [engine(), own] {
        for call in &calls {
            let error = engine.eval::<Dynamic>(call).unwrap_err().to_string();
            assert!(error.contains("Function not found"), "{call}: {error}");
        }
    }
    let written: Vec<_> = std::fs::read_dir(dir.path()).unwrap().collect();
    assert_eq!(written.len(), 1, "only the file the test wrote itself");
}

#[test]
fn scripts_cannot_import_files() {
    let dir = temp_dir();
    std::fs::write(dir.path().join("lib.rhai"), "export const ANSWER = 42;").unwrap();
    let path = dir.path().join("lib").to_string_lossy().replace('\\', "/");
    let script = format!("import \"{path}\" as lib; lib::ANSWER");
    // Rhai's default engine reads the module from disk...
    assert_eq!(Engine::new().eval::<INT>(&script).unwrap(), 42);
    // ...but not once this crate is registered, whoever created the engine.
    let mut own = Engine::new();
    scratchcad_occt_rhai::register(&mut own);
    for engine in [engine(), own] {
        let error = engine.eval::<INT>(&script).unwrap_err().to_string();
        assert!(error.contains("Module not found"), "{error}");
    }
}

#[test]
fn scripts_cannot_forge_error_kinds() {
    let forge = "let e = \"fake\"; e.tag = 9; throw e;";
    // Rhai's default engine lets scripts tag their values...
    let error = Engine::new().eval::<Dynamic>(forge).unwrap_err();
    assert_eq!(error_kind(&error), Some(ErrorKind::Cancelled));
    // ...but not once this crate is registered, whoever created the engine.
    let mut own = Engine::new();
    scratchcad_occt_rhai::register(&mut own);
    for engine in [engine(), own] {
        for script in [forge, "let e = \"fake\"; e.set_tag(9); e", "set_tag(\"fake\", 9)"] {
            let error = engine.eval::<Dynamic>(script).unwrap_err();
            assert_eq!(error_kind(&error), Some(ErrorKind::InvalidArgument), "{script}");
            assert!(error.to_string().contains("tags are read-only"), "{script}: {error}");
        }
        // Tags can still be read, and a caught error keeps its kind when re-thrown.
        assert_eq!(engine.eval::<INT>("let e = \"x\"; e.tag").unwrap(), 0);
        let error =
            engine.eval::<Dynamic>("try { box(0, 1, 1) } catch (e) { throw e }").unwrap_err();
        assert_eq!(error_kind(&error), Some(ErrorKind::InvalidArgument));
    }
}

#[test]
fn errors_carry_their_kind() {
    let tag = |script: &str| {
        run::<INT>(&format!("let t = -1; try {{ {script}; }} catch (e) {{ t = e.tag; }} t"))
    };
    assert_eq!(tag("box(0, 1, 1)"), ErrorKind::InvalidArgument.tag());
    assert_eq!(tag("box(1, 1, 1).faces()[10]"), ErrorKind::IndexOutOfRange.tag());
    assert_eq!(tag("box(1, 1, 1).faces(\"(>Z\")"), ErrorKind::Selector.tag());
    assert_eq!(tag("throw \"mine\""), 0, "values a script throws carry no kind");
    // Messages are unchanged.
    let message = run::<String>("let m = \"\"; try { box(0, 1, 1); } catch (e) { m = e; } m");
    assert!(message.contains("box x size must be positive"), "{message}");

    // Like a failed shell, a failed fillet says what to change, as an invalid argument.
    let error = engine().eval::<Dynamic>("box(1, 1, 1).fillet(50)").unwrap_err();
    assert_eq!(error_kind(&error), Some(ErrorKind::InvalidArgument));
    let error = engine().eval::<Dynamic>("box(1, 1, 0)").unwrap_err();
    assert_eq!(error_kind(&error), Some(ErrorKind::InvalidArgument));
    let error = engine().eval::<Dynamic>("no_such_function()").unwrap_err();
    assert_eq!(error_kind(&error), None);
}

#[test]
fn point_queries_and_mesh_options_in_scripts() {
    assert!(run::<bool>("box(2, 2, 2).contains([1, 1, 1])"));
    assert!(!run::<bool>("box(2, 2, 2).contains(vec3(3, 1, 1))"));
    assert_eq!(run::<String>("box(2, 2, 2).classify([1, 1, 1])"), "inside");
    assert_eq!(run::<String>("box(2, 2, 2).classify([2, 1, 1])"), "on");
    assert_eq!(run::<String>("box(2, 2, 2).classify([5, 1, 1])"), "outside");
    fails("circle(1).contains([0, 0, 0])", "expected solid");
    fails("box(1, 1, 1).contains(\"middle\")", "point must be a vec3");

    let coarse = run::<INT>("(cylinder(1, 1) - cylinder(0.2, 1)).mesh(0.1).triangle_count");
    let fine = run::<INT>("(cylinder(1, 1) - cylinder(0.2, 1)).mesh(0.1, 5).triangle_count");
    assert!(fine > coarse);
    fails("box(1, 1, 1).mesh(0.1, \"fine\")", "angular tolerance must be a number");
    assert_eq!(run::<INT>("box(1, 1, 1).mesh(0.1).welded().vertex_count"), 8);
}

#[test]
fn bundled_examples_run() {
    let examples = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("examples");
    let mut count = 0;
    for entry in std::fs::read_dir(&examples).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().is_some_and(|e| e == "rhai") {
            let source = std::fs::read_to_string(&path).unwrap();
            let shape = eval_shape(&source).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
            assert!(shape.is_valid(), "{} produced an invalid shape", path.display());
            assert!(shape.volume().unwrap() > 0.0, "{}", path.display());
            count += 1;
        }
    }
    assert!(count >= 4);
}

#[test]
fn booleans_that_return_invalid_shapes_fail() {
    // A thread lofted onto a core whose surface its root edge only touches: the fuse "succeeds",
    // but returns an invalid shape, which a later common silently dropped.
    let script = r#"
        let r_major = 3.0;
        let r_minor = 2.3866;
        let w = 0.4167;
        let section = polygon([[r_minor - 0.3, 0, -w], [r_minor, 0, -w], [r_major, 0, -0.0625],
                               [r_major, 0, 0.0625], [r_minor, 0, w], [r_minor - 0.3, 0, w]]);
        let sections = [];
        for i in 0..=252 {
            let t = i.to_float() / 12.0;
            sections.push(section.rotate_z(t * 360.0).translate([0, 0, t - 1.0]));
        }
        let core = cylinder([0, 0, -0.5], "Z", r_minor, 20.5);
        core + loft(sections, true)
    "#;
    fails(script, "the fuse returned an invalid shape (OpenCASCADE reported: ");
    fails(script, "acquired self intersection");
    fails(script, "(line 13, position 14)");
    // Healthy booleans, including one fusing shapes that share a face, pass.
    run::<Shape>("(box(2, 2, 2) + box(1, 1, 1).translate([2, 0, 0])) - cylinder(0.5, 9)");
}

/// One start of a 4-start T8 lead screw thread running out past both ends of its core:
/// OpenCASCADE misses that they meet, and fuses them into a compound of the two overlapping
/// solids without an error or a warning.
pub const GRAZING_FUSE: &str = r#"
    let section = polygon([[2.7, 0, -0.6], [3.05, 0, -0.6], [4.0, 0, -0.3], [4.0, 0, 0.3],
                           [3.05, 0, 0.6], [2.7, 0, 0.6]]);
    let sections = [];
    for i in 0..=60 {
        let t = i.to_float() / 12.0;
        sections.push(section.rotate_z(t * 360.0 + 180.0).translate([0, 0, -8.0 + t * 8.0]));
    }
    let core = cylinder([0, 0, -0.5], "Z", 3.1, 31.0);
    core + loft(sections, true)
"#;

#[test]
fn booleans_that_miss_an_overlap_fail() {
    // The fuse loses volume: less than the larger solid on its own.
    fails(GRAZING_FUSE, "the fuse returned a volume of 800.34");
    fails(GRAZING_FUSE, "where it must be at least 935.91");
    // The common misses the overlap too.
    fails(
        &GRAZING_FUSE.replace("core + loft", "core & loft"),
        "the common found nothing in common",
    );
}

#[test]
fn checks_long_lofts_exactly() {
    // A 42-turn SM1 thread groove cut to length: integrated directly, the common's volume came
    // out 30% too high, 2020.9 against at most 1545.8, though its exact volume is 1540.7. Measured
    // exactly, the check passes it.
    let script = r#"
        const pitch = 0.635;
        const r_major = 13.1445;
        let r_minor = r_major - 0.541 * pitch;
        let w = pitch / 16.0 + (r_major + 0.05 - (r_minor - 0.05)) * (30.0 * PI() / 180.0).tan();
        let section = polygon([[r_minor - 0.6, 0, -w], [r_minor - 0.05, 0, -w], [r_major + 0.05, 0, -pitch / 16.0],
                               [r_major + 0.05, 0, pitch / 16.0], [r_minor - 0.05, 0, w], [r_minor - 0.6, 0, w]]);
        let sections = [];
        for i in 0..=(42 * 12) {
            let t = i.to_float() / 12.0;
            sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
        }
        loft(sections, true).translate([0, 0, -pitch]) & cylinder(20.0, 27.4)
    "#;
    let groove = eval_shape(script).unwrap();
    assert!(groove.is_valid());
    assert_close(groove.volume().unwrap(), 1540.68, 0.01);
}

#[test]
fn cuts_that_remove_nothing_fail() {
    // A helical groove lofted as a square section: OpenCASCADE's cut split the cylinder's faces
    // where the groove meets them, but removed none of its 148 mm³.
    let script = r#"
        let r = 13.0;
        let s = polygon([[r - 0.8, 0, -0.3], [r + 0.5, 0, -0.3], [r + 0.5, 0, 0.3], [r - 0.8, 0, 0.3]]);
        let a = [];
        for i in 0..=36 { let t = i.to_float() / 12.0; a.push(s.rotate_z(t * 360.0).translate([0, 0, t * 1.5])); }
        cylinder(r, 4.0) - loft(a, true)
    "#;
    fails(script, "the cut removed nothing, although the shapes overlap");
}

#[test]
fn cuts_that_remove_everything_fail() {
    // A duct and its inside, lofted through three sections each: OpenCASCADE's cut of one from
    // the other came out empty.
    let script = r#"
        let outer = loft([rect(plane([0, 0, 25], "Z"), 20, 15), rect(plane([0, 4, 12.5], [0, 0.3, 1]), 22, 9),
                          rect(plane([0, 12, 0], [0, 1, 0.5]), 30, 3)], true);
        let inner = loft([rect(plane([0, 0, 26.01], "Z"), 17.6, 12.6), rect(plane([0, 4, 12.5], [0, 0.3, 1]), 19.6, 6.6),
                          rect(plane([0, 12.5, -0.25], [0, 1, 0.5]), 27.6, 0.6)], true);
        outer - inner
    "#;
    fails(script, "the cut removed everything");
}

#[test]
fn circles_along_a_helix_start_on_top() {
    // Their normals turn all the way around Z; OpenCASCADE's own choice of where each circle
    // starts jumped to the opposite side, which twisted lofts through them.
    for k in 0..24 {
        let a = (k as f64 * 15.0).to_radians();
        let center = v(10.0 * a.cos(), 10.0 * a.sin(), 0.0);
        let normal = v(-a.sin(), a.cos(), 0.2);
        let circle = Shape::circle(center, normal, 1.0).unwrap();
        let start = circle.edges().first().unwrap().start_point().unwrap();
        assert!(start.z - center.z > 0.95, "{k}: {start}");
    }
    // A circle in the XY plane still starts on +X.
    let flat = Shape::circle(DVec3::ZERO, DVec3::Z, 2.0).unwrap();
    assert_vec_close(flat.edges().first().unwrap().start_point().unwrap(), v(2.0, 0.0, 0.0), 1e-9);
}

#[test]
fn vectors_index_like_arrays() {
    assert_close(run::<f64>("let v = vec3(1, 2, 3); v[0] + v[1] * 10 + v[-1] * 100"), 321.0, 0.0);
    assert_close(run::<f64>("let v = box(1, 2, 3).bounding_box().max; v[2]"), 3.0, 1e-6);
    assert_close(run::<f64>("let v = vec3(1, 2, 3); v[1] = 7; v.y"), 7.0, 0.0);
    fails("vec3(1, 2, 3)[3]", "components 0 to 2");
    fails("let v = vec3(1, 2, 3); v[-4] = 1", "components 0 to 2");
}

#[test]
fn compound_tools_may_overlap() {
    // A clearance hole and its counterbore cut as one compound, as the guide suggests for many
    // holes: OpenCASCADE takes a compound operand to hold no overlapping shapes, so the
    // counterbore used to be left uncut.
    let setup = r#"
        let blk = box_centered(30, 30, 20);
        let holes = compound([cylinder([0, 0, -15], "Z", 3.3, 30.0), cylinder([0, 0, 4], "Z", 5.5, 10.0)]);
    "#;
    let f = |expr: &str| run::<f64>(&format!("{setup} {expr}"));
    let separately = f("(blk - cylinder([0, 0, -15], \"Z\", 3.3, 30.0) - cylinder([0, 0, 4], \"Z\", 5.5, 10.0)).volume()");
    assert_close(f("(blk - holes).volume()"), separately, 1e-6);
    assert_close(f("(blk & holes).volume()"), 18000.0 - separately, 1e-6);
    assert_eq!(
        run::<INT>(&format!("{setup} (blk + holes.translate([20, 0, 0])).solids().len()")),
        1
    );
}
