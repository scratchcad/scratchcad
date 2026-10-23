mod common;

use common::{assert_close, assert_vec_close, cube10, err, err_contains, v};
use scratchcad_occt_rhai::{ffi, DVec2, DVec3, Error, Plane, PointLocation, Shape, ShapeType};
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
    // Many shapes fuse in one operation: a 150 x 3 x 2 bar with 50 pins sunk 1 mm into it.
    let mut parts = vec![Shape::make_box(150.0, 3.0, 2.0).unwrap()];
    parts.extend((0..50).map(|i| {
        Shape::cylinder_at(v(1.5 + 3.0 * i as f64, 1.5, 1.0), DVec3::Z, 1.0, 5.0).unwrap()
    }));
    let comb = Shape::fuse_all(&parts).unwrap();
    assert_eq!(comb.solids().len(), 1);
    assert_close(comb.volume().unwrap(), 900.0 + 50.0 * PI * 4.0, 1e-6);
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
fn measures_spline_solids_exactly() {
    // A wavy closed spline through 40 points. Integrated directly, the prism's volume came out
    // 0.6% high and its cap's area 0.1% low, because their B-spline faces have many spans.
    let points: Vec<DVec3> = (0..40)
        .map(|i| {
            let a = i as f64 / 40.0 * 2.0 * PI;
            let r = 10.0 + 2.0 * (5.0 * a).sin();
            v(r * a.cos(), r * a.sin(), 0.0)
        })
        .collect();
    let spline = Shape::spline(&points, true).unwrap();
    // The reference: a polygon through 20000 points on the spline.
    let samples: Vec<DVec3> =
        (0..20000).map(|i| spline.point_at(i as f64 / 20000.0).unwrap()).collect();
    let (mut area, mut perimeter) = (0.0, 0.0);
    for (i, p) in samples.iter().enumerate() {
        let q = samples[(i + 1) % samples.len()];
        area += (p.x * q.y - q.x * p.y) / 2.0;
        perimeter += p.distance(q);
    }

    let face = Shape::face_from(&Shape::wire_from(&[spline]).unwrap()).unwrap();
    assert_close(face.area().unwrap(), area, 1e-6 * area);
    let prism = face.extrude(v(0.0, 0.0, 40.0)).unwrap();
    let surface = 2.0 * area + perimeter * 40.0;
    assert_close(prism.volume().unwrap(), area * 40.0, 1e-6 * area * 40.0);
    assert_close(prism.area().unwrap(), surface, 1e-6 * surface);
    assert_close(prism.center().unwrap().z, 20.0, 1e-6);
    let mass = prism.mass_properties().unwrap();
    assert_close(mass.volume, area * 40.0, 1e-6 * area * 40.0);
    assert_close(mass.area, surface, 1e-6 * surface);
    assert_vec_close(mass.center, prism.center().unwrap(), 1e-9);

    // A loft through copies of the section turned as they rise is a twisted prism of the same
    // volume (to within how closely the loft follows the sections).
    let sections: Vec<Shape> = (0..5)
        .map(|k| {
            let section = Shape::wire_from(&[Shape::spline(&points, true).unwrap()]).unwrap();
            let raised = section.translate(v(0.0, 0.0, 10.0 * k as f64)).unwrap();
            raised.rotate(DVec3::ZERO, DVec3::Z, 5.0 * k as f64).unwrap()
        })
        .collect();
    let twisted = Shape::loft(&sections, true).unwrap();
    assert_close(twisted.volume().unwrap(), area * 40.0, 1e-3 * area * 40.0);
    // Shapes without faces still measure: a wire has no volume or area, and its center is
    // the middle of its length.
    let wire = Shape::wire_from(&[Shape::line(DVec3::ZERO, v(4.0, 0.0, 0.0)).unwrap()]).unwrap();
    let mass = wire.mass_properties().unwrap();
    assert_eq!((mass.volume, mass.area), (0.0, 0.0));
    assert_vec_close(mass.center, v(2.0, 0.0, 0.0), 1e-9);
}

#[test]
fn measuring_leaves_shapes_alone() {
    // A torus fused with a cylinder through its tube: the intersection edges are B-splines, so
    // the fuse is measured on a copy split into Bézier patches. Splitting the shape itself
    // changed the edges it shares with the torus, which then cut to nothing; and splitting the
    // edges on the torus, which wraps around both ways, lost the torus's volume.
    let torus = Shape::torus(17.5, 5.0).unwrap();
    let cylinder = Shape::cylinder_at(v(17.5, 0.0, -10.0), DVec3::Z, 2.0, 20.0).unwrap();
    let side = Shape::box_from_corners(v(10.0, -50.0, -50.0), v(50.0, 50.0, 50.0)).unwrap();
    let before = torus.cut(&side).unwrap().volume().unwrap();
    let fused = torus.fuse(&cylinder).unwrap();
    // 2 pi^2 R r^2 for the torus, and 128.232 of the cylinder outside it (integrated numerically).
    let exact = 2.0 * PI * PI * 17.5 * 25.0 + 128.232008;
    let mass = fused.mass_properties().unwrap();
    assert_close(mass.volume, exact, 1e-6 * exact);
    assert_close(fused.volume().unwrap(), exact, 1e-6 * exact);
    assert!(fused.is_valid() && torus.is_valid());
    assert_close(torus.cut(&side).unwrap().volume().unwrap(), before, 1e-9 * before);
}

#[test]
fn helical_slots_grazing_a_bore_cut_and_measure() {
    // A helical slot whose inner edge runs along a bore of the same radius. Lofted by
    // OpenCASCADE, the cut's result couldn't be split into Bézier patches to be measured; this
    // loft's cuts and measures, close to a ruled loft through the same sections.
    let blade = Shape::polygon(&[
        v(2.5, 0.0, -0.35),
        v(10.5, 0.0, -0.35),
        v(10.5, 0.0, 0.35),
        v(2.5, 0.0, 0.35),
    ])
    .unwrap();
    let sections: Vec<Shape> = (0..=36)
        .map(|i| {
            let t = i as f64 / 12.0;
            let turned = blade.rotate(DVec3::ZERO, DVec3::Z, t * 360.0).unwrap();
            turned.translate(v(0.0, 0.0, 8.0 + t * 3.0)).unwrap()
        })
        .collect();
    let tube =
        Shape::cylinder(9.5, 25.0).unwrap().cut(&Shape::cylinder(2.5, 25.0).unwrap()).unwrap();
    let smooth = tube.cut(&Shape::loft(&sections, true).unwrap()).unwrap();
    let ruled = tube.cut(&Shape::ruled_loft(&sections, true).unwrap()).unwrap();
    assert!(smooth.is_valid());
    let (s, r) = (smooth.volume().unwrap(), ruled.volume().unwrap());
    assert_close(s, r, 1e-3 * r);
}

#[test]
fn measures_shells_of_spline_solids_exactly() {
    // Shelling a spline-sided solid makes offset surfaces, which can't be turned into Bézier
    // patches; split where their base surface's knots are, they integrate exactly too. A smooth
    // outline's inward offset by d has the area A - P d + pi d², so the walls of a cup shelled d
    // thick hold A h - (A - P d + pi d²)(h - d).
    let points: Vec<DVec3> = (0..36)
        .map(|i| {
            let a = (i as f64 * 10.0).to_radians();
            let r = 10.0 * (1.0 + 0.08 * (3.0 * a).cos());
            v(r * a.cos(), r * a.sin(), 0.0)
        })
        .collect();
    let outline = Shape::wire_from(&[Shape::spline(&points, true).unwrap()]).unwrap();
    let base = Shape::face_from(&outline).unwrap();
    let (area, perimeter) = (base.area().unwrap(), base.length().unwrap());
    let (h, d) = (10.0, 0.5);
    let solid = base.extrude(v(0.0, 0.0, h)).unwrap();
    let top = solid.faces().farthest(DVec3::Z).unwrap();
    let cup = solid.shell(-d, top.shapes()).unwrap();
    assert!(cup.is_valid());
    assert!(cup.faces().iter().any(|f| f.geom_type().unwrap() == "offset"));
    let walls = area * h - (area - perimeter * d + PI * d * d) * (h - d);
    assert_close(cup.volume().unwrap(), walls, 1e-7 * walls);
}

#[test]
fn bounding_boxes_are_tight_on_trimmed_curved_faces() {
    // A tube swept along a helix and cut square at z = 0 and z = 6: OpenCASCADE alone bounds its
    // cut B-spline face as if it were uncut, half the wire's thickness below 0 and above 6.
    let points: Vec<DVec3> = (0..=72)
        .map(|i| {
            let a = (i as f64 * 15.0).to_radians();
            v(4.5 * a.cos(), 4.5 * a.sin(), i as f64 * 0.125)
        })
        .collect();
    let path = Shape::wire_from(&[Shape::spline(&points, false).unwrap()]).unwrap();
    let wire = Shape::circle(v(4.5, 0.0, 0.0), DVec3::Y, 0.5).unwrap();
    let coil = Shape::face_from(&wire).unwrap().sweep(&path).unwrap();
    let cut = coil.common(&Shape::box_from_corners(v(-9.0, -9.0, 0.0), v(9.0, 9.0, 6.0)).unwrap());
    let b = cut.unwrap().bounding_box().unwrap();
    assert_close(b.min.z, 0.0, 1e-6);
    assert_close(b.max.z, 6.0, 1e-6);
    assert_close(b.max.x, 5.0, 1e-4);

    // A tilted torus reaches R sin(tilt) + r up and down.
    let torus = Shape::torus(17.5, 5.0).unwrap().rotate(DVec3::ZERO, DVec3::X, 37.0).unwrap();
    let b = torus.bounding_box().unwrap();
    let reach = 17.5 * 37f64.to_radians().sin() + 5.0;
    assert_close(b.max.z, reach, 1e-6);
    assert_close(b.min.z, -reach, 1e-6);
    assert_close(b.max.x, 22.5, 1e-6);
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
    // Circles around four turns of a helix, which loft only without matching up their vertices.
    let base = Shape::circle(v(4.5, 0.0, 0.0), v(0.0, 9.0 * PI, 3.0), 0.5).unwrap();
    let coil: Vec<Shape> = (0..=48)
        .map(|i| {
            let t = i as f64 / 12.0;
            let turned = base.rotate(DVec3::ZERO, DVec3::Z, t * 360.0).unwrap();
            turned.translate(v(0.0, 0.0, t * 3.0)).unwrap()
        })
        .collect();
    let length = 4.0 * (81.0 * PI * PI + 9.0f64).sqrt();
    let wound = Shape::loft(&coil, true).unwrap();
    assert!(wound.is_valid());
    assert_close(wound.volume().unwrap(), PI * 0.25 * length, 0.01 * PI * 0.25 * length);
    err_contains(Shape::loft(&[bottom], true), "at least 2 sections");
    err_contains(Shape::loft(&[Shape::cube(1.0).unwrap(), top], true), "expected wire, got solid");
}

#[test]
fn lofts_through_unevenly_spaced_sections() {
    // Circles of radius 11 to 16 at x = 0, 90, 172 and 180. OpenCASCADE's smooth loft swung past
    // them, to a radius between 4.3 and 21.4; this one stays between each pair of sections, and
    // passes through every one.
    let rings: Vec<Shape> = [(0.0, 12.0), (90.0, 13.0), (172.0, 16.0), (180.0, 11.0)]
        .iter()
        .map(|(x, r)| Shape::circle(v(*x, 0.0, 0.0), DVec3::X, *r).unwrap())
        .collect();
    let radius_at = |loft: &Shape, x: f64| {
        let slice = Shape::box_centered(0.2, 200.0, 200.0).unwrap().translate(v(x, 0.0, 0.0));
        loft.common(&slice.unwrap()).unwrap().bounding_box().unwrap().size().y / 2.0
    };
    let smooth = Shape::loft(&rings, true).unwrap();
    assert!(smooth.is_valid());
    for (x, lo, hi) in [
        (10.0, 12.0, 13.0),
        (45.0, 12.0, 13.0),
        (89.0, 12.0, 13.0),
        (91.0, 13.0, 16.0),
        (135.0, 13.0, 16.0),
        (171.0, 13.0, 16.0),
        (173.0, 11.0, 16.0),
        (176.0, 11.0, 16.0),
        (179.0, 11.0, 16.0),
    ] {
        let r = radius_at(&smooth, x);
        assert!((lo - 1e-6..=hi + 1e-6).contains(&r), "radius {r} at x = {x}");
    }
    for ring in &rings {
        for k in 0..8 {
            let p = ring.edges().shapes()[0].point_at(k as f64 / 8.0).unwrap();
            assert_eq!(smooth.classify(p).unwrap(), PointLocation::OnBoundary, "{p}");
        }
    }
    // A ruled loft runs straight from each section to the next: the slices' widest ends, at
    // x = 45.1 and 175.9, are where they are measured.
    let ruled = Shape::ruled_loft(&rings, true).unwrap();
    assert!(ruled.is_valid());
    assert_close(radius_at(&ruled, 45.0), 12.0 + 45.1 / 90.0, 1e-4);
    assert_close(radius_at(&ruled, 176.0), 16.0 - 5.0 * 3.9 / 8.0, 1e-4);
    let skin = Shape::ruled_loft(&rings[..2], false).unwrap();
    assert_eq!(skin.shape_type(), ShapeType::Shell);
    err_contains(Shape::ruled_loft(&rings[..1], true), "at least 2 sections");
}

/// A rectangle 2w by 2d with its corners rounded to r, at height z: lines and arcs that meet
/// tangentially.
fn rounded_rect(z: f64, w: f64, d: f64, r: f64) -> Shape {
    // Each arc's midpoint is c in from its corner in x and in y.
    let c = r - r * std::f64::consts::FRAC_1_SQRT_2;
    let parts = [
        Shape::line(v(w, -d + r, z), v(w, d - r, z)),
        Shape::arc(v(w, d - r, z), v(w - c, d - c, z), v(w - r, d, z)),
        Shape::line(v(w - r, d, z), v(-w + r, d, z)),
        Shape::arc(v(-w + r, d, z), v(-w + c, d - c, z), v(-w, d - r, z)),
        Shape::line(v(-w, d - r, z), v(-w, -d + r, z)),
        Shape::arc(v(-w, -d + r, z), v(-w + c, -d + c, z), v(-w + r, -d, z)),
        Shape::line(v(-w + r, -d, z), v(w - r, -d, z)),
        Shape::arc(v(w - r, -d, z), v(w - c, -d + c, z), v(w, -d + r, z)),
    ];
    Shape::wire_from(&parts.map(Result::unwrap)).unwrap()
}

fn regular(z: f64, sides: usize, r: f64) -> Shape {
    let points: Vec<DVec3> = (0..sides)
        .map(|i| {
            let a = 2.0 * PI * i as f64 / sides as f64;
            v(r * a.cos(), r * a.sin(), z)
        })
        .collect();
    Shape::polygon(&points).unwrap()
}

#[test]
fn lofts_through_sections_of_several_edges() {
    // Rounded rectangles and a circle: one face per matched edge, tangent where the sections are
    // smooth, so the rims fillet and the solid shells.
    let sections = [
        rounded_rect(0.0, 20.0, 10.0, 4.0),
        Shape::circle(v(0.0, 0.0, 25.0), DVec3::Z, 12.0).unwrap(),
        rounded_rect(50.0, 15.0, 8.0, 3.0),
    ];
    let duct = Shape::loft(&sections, true).unwrap();
    assert!(duct.is_valid());
    let top = duct.edges().select(">Z").unwrap();
    let rounded = duct.fillet(1.0, top.shapes()).unwrap();
    assert!(rounded.is_valid() && rounded.volume().unwrap() < duct.volume().unwrap());
    let cup = duct.shell(-1.0, duct.faces().select(">Z").unwrap().shapes()).unwrap();
    assert!(cup.is_valid());
    // The sections are smooth where their edges meet, so the faces either side of every edge
    // running along the duct are tangent across it, to within the ten-thousandth of a degree that
    // fillets tell a corner by: there is none there to round.
    let along: Vec<Shape> =
        duct.edges().iter().filter(|e| e.bounding_box().unwrap().size().z > 1.0).cloned().collect();
    assert!(along.len() >= 8, "{} edges along the duct", along.len());
    err_contains(duct.fillet(1.0, &along), "faces that continue each other");
    // A square, a hexagon and a circle: their corners don't match, so their edges are split to
    // match. The rim on the circle fillets.
    let mixed = Shape::loft(
        &[
            regular(20.0, 4, 14.0),
            regular(45.0, 6, 13.0),
            Shape::circle(v(0.0, 0.0, 70.0), DVec3::Z, 12.0).unwrap(),
        ],
        true,
    )
    .unwrap();
    assert!(mixed.is_valid());
    let rim = mixed.edges().select(">Z").unwrap();
    assert!(mixed.fillet(1.0, rim.shapes()).unwrap().is_valid());
    // A triangle, a square and a hexagon: the triangle's sides are split where the others have
    // corners, and the faces either side of each split start out tangent. The loft is as
    // symmetric as its sections, and the triangle's rim fillets.
    let polygons =
        Shape::loft(&[regular(0.0, 3, 15.0), regular(20.0, 4, 14.0), regular(45.0, 6, 13.0)], true)
            .unwrap();
    assert!(polygons.is_valid());
    let mirrored = polygons.mirror(DVec3::ZERO, DVec3::Y).unwrap();
    assert!(
        polygons.common(&mirrored).unwrap().volume().unwrap()
            > 0.999999 * polygons.volume().unwrap()
    );
    let rim = polygons.edges().select("<Z").unwrap();
    for r in [0.5, 1.0, 2.0] {
        assert!(polygons.fillet(r, rim.shapes()).unwrap().is_valid(), "r = {r}");
    }
}

#[test]
fn lofts_are_the_same_wherever_the_part_is() {
    let rings: Vec<Shape> = [(0.0, 12.0), (90.0, 13.0), (172.0, 16.0), (180.0, 11.0)]
        .iter()
        .map(|(x, r)| Shape::circle(v(*x, 0.0, 0.0), DVec3::X, *r).unwrap())
        .collect();
    let moved: Vec<Shape> = rings
        .iter()
        .map(|r| {
            r.rotate(DVec3::ZERO, v(0.3, 0.5, 0.8), 40.0)
                .unwrap()
                .translate(v(5.0, -7.0, 11.0))
                .unwrap()
        })
        .collect();
    let here = Shape::loft(&rings, true).unwrap();
    let there = Shape::loft(&moved, true).unwrap();
    assert_close(there.volume().unwrap(), here.volume().unwrap(), 1e-9 * here.volume().unwrap());
    let back =
        there.translate(v(-5.0, 7.0, -11.0)).unwrap().rotate(DVec3::ZERO, v(0.3, 0.5, 0.8), -40.0);
    assert_vec_close(back.unwrap().center().unwrap(), here.center().unwrap(), 1e-9);
}

#[test]
fn lofts_that_cannot_be_built_say_why() {
    let ring = |z: f64, r: f64| Shape::circle(v(0.0, 0.0, z), DVec3::Z, r).unwrap();
    err_contains(
        Shape::loft(&[ring(0.0, 5.0), ring(0.0, 5.0)], true),
        "sections 1 and 2 are the same",
    );
    let open =
        Shape::wire_from(&[Shape::line(v(-5.0, 0.0, 10.0), v(5.0, 0.0, 10.0)).unwrap()]).unwrap();
    err_contains(
        Shape::loft(&[ring(0.0, 5.0), open.clone()], true),
        "every section must be a closed wire",
    );
    err_contains(
        Shape::loft(&[open.clone(), open.translate(v(0.0, 0.0, 5.0)).unwrap()], true),
        "a solid loft needs closed sections",
    );
    err_contains(
        Shape::loft(
            &[
                open.clone(),
                open.translate(v(0.0, 3.0, 5.0)).unwrap(),
                open.translate(v(0.0, 0.0, 10.0)).unwrap(),
            ],
            false,
        ),
        "section 1 is straight",
    );
    // An end section that isn't flat can't be capped.
    let bent = Shape::spline(
        &[v(5.0, 0.0, 0.0), v(0.0, 5.0, 1.0), v(-5.0, 0.0, 0.0), v(0.0, -5.0, 1.0)],
        true,
    )
    .unwrap();
    err_contains(
        Shape::loft(&[bent, ring(10.0, 5.0)], true),
        "an end section of a solid loft must lie in a plane",
    );
    // Open sections loft into a shell.
    let arc =
        |z: f64| Shape::arc(v(-5.0, 0.0, z), v(0.0, 3.0 + z / 10.0, z), v(5.0, 0.0, z)).unwrap();
    let sheet = Shape::loft(&[arc(0.0), arc(5.0), arc(12.0)], false).unwrap();
    assert_eq!(sheet.shape_type(), ShapeType::Shell);
    assert!(sheet.is_valid());
}

#[test]
fn sweeps_along_paths_that_cross_themselves_fail() {
    // A paper clip: a wire swept along a polyline through arcs of points that doubles back and
    // crosses itself, with the profile a little off square. BRepOffsetAPI_MakePipe returned a
    // solid its checker passes, of 1 mm³ where the wire holds 71; the pipe shell's is invalid.
    let arc = |cx: f64, cy: f64, r: f64, from: f64, to: f64, n: usize| -> Vec<DVec3> {
        (0..=n)
            .map(|i| {
                let a = (from + (to - from) * i as f64 / n as f64).to_radians();
                v(cx + r * a.cos(), cy + r * a.sin(), 0.0)
            })
            .collect()
    };
    let mut points = vec![v(11.55, -2.5, 0.0)];
    points.extend(arc(28.0, 0.0, 5.0, -90.0, 90.0, 8));
    points.extend(arc(4.0, 0.5, 4.0, 90.0, 270.0, 8));
    points.extend(arc(25.0, -0.25, 2.25, -90.0, 90.0, 6));
    points.push(v(9.9, 2.0, 0.0));
    let wire = Shape::face_from(&Shape::circle(points[0], DVec3::X, 0.45).unwrap()).unwrap();
    let error = err(wire.sweep(&Shape::polyline(&points).unwrap())).to_string();
    assert!(error.contains("sweep failed: the swept shape is invalid"), "{error}");
    assert!(error.contains("square to it: circle(points[0]"), "{error}");

    // Along a spline through the same points, with the profile square to it, it sweeps right.
    let path = Shape::wire_from(&[Shape::spline(&points, false).unwrap()]).unwrap();
    let square = path.edges().first().unwrap().tangent_at(0.0).unwrap();
    let profile = Shape::face_from(&Shape::circle(points[0], square, 0.45).unwrap()).unwrap();
    let clip = profile.sweep(&path).unwrap();
    assert_close(clip.volume().unwrap(), PI * 0.45 * 0.45 * path.length().unwrap(), 0.01);

    // Around a ring of straight runs, BRepOffsetAPI_MakePipe's pieces cancelled out completely;
    // the pipe shell mitres the corners and sweeps it right.
    let ring: Vec<DVec3> = (0..=16)
        .map(|i| {
            let a = (i as f64 * 22.5).to_radians();
            v(10.0 * a.cos(), 10.0 * a.sin(), 0.0)
        })
        .collect();
    let path = Shape::polyline(&ring).unwrap();
    let profile = Shape::face_from(&Shape::circle(ring[0], ring[1] - ring[0], 1.0).unwrap());
    let swept = profile.unwrap().sweep(&path).unwrap();
    assert_close(swept.volume().unwrap(), PI * path.length().unwrap(), 1e-3 * PI * 62.4);
}

#[test]
fn sweeps_follow_helices_corners_and_holes() {
    // A spring of ten turns at 3.5 mm pitch.
    let spring = |pitch: &dyn Fn(f64) -> f64| {
        let mut z = 0.0;
        let points: Vec<DVec3> = (0..=240)
            .map(|i| {
                let t = i as f64 / 24.0;
                let a = t * 2.0 * PI;
                let p = v(4.5 * a.cos(), 4.5 * a.sin(), z);
                z += pitch(t) / 24.0;
                p
            })
            .collect();
        Shape::spline(&points, false).unwrap()
    };
    let path = spring(&|_| 3.5);
    // With the profile square to the path, the coil holds its area times the path's length.
    let square = path.tangent_at(0.0).unwrap();
    let wire = Shape::face_from(&Shape::circle(v(4.5, 0.0, 0.0), square, 0.5).unwrap()).unwrap();
    let coil = wire.sweep(&path).unwrap();
    assert!(coil.is_valid());
    assert_close(coil.volume().unwrap(), PI * 0.25 * path.length().unwrap(), 1e-3);
    // A closed-end spring: one turn at 1.5 mm pitch, eight at 3.5, one at 1.5. BRepOffsetAPI_MakePipe
    // crashed the process on it; the pipe shell can't keep the profile square along it, and says so.
    let closed = spring(&|t| if !(1.0..9.0).contains(&t) { 1.5 } else { 3.5 });
    err_contains(wire.sweep(&closed), "fails along some long helices whose pitch changes");

    // A tube: the hole in the profile sweeps too.
    let ring = Shape::face_with_holes(
        &Shape::circle(DVec3::ZERO, DVec3::Z, 2.0).unwrap(),
        &[Shape::circle(DVec3::ZERO, DVec3::Z, 1.0).unwrap()],
    )
    .unwrap();
    let tube = ring.sweep(&Shape::line(DVec3::ZERO, v(0.0, 0.0, 10.0)).unwrap()).unwrap();
    assert_close(tube.volume().unwrap(), PI * 3.0 * 10.0, 1e-6);

    // An open profile sweeps into a sheet, and a path may turn a corner.
    let corner = Shape::polyline(&[DVec3::ZERO, v(0.0, 0.0, 10.0), v(10.0, 0.0, 10.0)]).unwrap();
    let square = Shape::rect_on(&Plane::named("XY").unwrap(), 2.0, 2.0).unwrap();
    let bent = square.sweep(&corner).unwrap();
    assert!(bent.is_valid());
    assert_close(bent.volume().unwrap(), 4.0 * 20.0, 1e-6);
    let sheet = Shape::line(v(-1.0, 0.0, 0.0), v(1.0, 0.0, 0.0)).unwrap().sweep(&corner).unwrap();
    assert!(sheet.solids().is_empty() && !sheet.faces().is_empty());
    // A picture hook: a line turning a corner into an arc. Only BRepOffsetAPI_MakePipe swept
    // it; the pipe shell's mitred corner is invalid, which is an error.
    let hook = Shape::wire_from(&[
        Shape::line(v(0.0, 0.6, 2.0), v(0.0, 6.0, -2.4)).unwrap(),
        Shape::arc(v(0.0, 6.0, -2.4), v(0.0, 12.0, -8.4), v(0.0, 15.6, -1.2)).unwrap(),
    ])
    .unwrap();
    let wire = Shape::circle(v(0.0, 0.6, 2.0), v(0.0, 5.4, -4.4), 1.5).unwrap();
    err_contains(Shape::face_from(&wire).unwrap().sweep(&hook), "the swept shape is invalid");
    // A point sweeps into a copy of the path.
    let traced = Shape::vertex_at(DVec3::ZERO).unwrap().sweep(&corner).unwrap();
    assert_close(traced.length().unwrap(), 20.0, 1e-9);
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
fn fillets_and_chamfers_that_break_the_solid_fail() {
    // A chamfer wider than the rounded corners beside its edges: OpenCASCADE reports success and
    // returns an invalid solid.
    let plate = Shape::make_box(20.0, 20.0, 6.0).unwrap();
    let rounded = plate.fillet(3.0, plate.edges().select("|Z").unwrap().shapes()).unwrap();
    let top = rounded.edges().select(">Z").unwrap();
    assert!(rounded.chamfer(2.9, top.shapes()).unwrap().is_valid());
    err_contains(
        rounded.chamfer(3.5, top.shapes()),
        "chamfer failed: a chamfer of the 8 selected edges with distance 3.5 gave an invalid solid",
    );
    // A pyramid lofted onto a plate, its vertical edges chamfered.
    let cap = scratchcad_occt_rhai::eval_shape(
        r#"box_centered(100, 100, 4).translate([0, 0, 2])
            + loft([rect(plane([0, 0, 3.9], "Z"), 100, 100), rect(plane([0, 0, 30], "Z"), 4, 4)], true)"#,
    )
    .unwrap();
    assert!(cap.is_valid());
    let error = err(cap.chamfer(1.0, cap.edges().select("|Z").unwrap().shapes())).to_string();
    assert!(error.contains("gave an invalid solid"), "{error}");
    assert!(error.contains("Try a smaller distance, or bevel fewer edges at a time"), "{error}");
}

#[test]
fn fillets_of_faces_a_boolean_split_say_to_clean() {
    // A hub with two lobes on bridges, fused flush: the top stays split into coplanar faces,
    // and selecting the top edges picks up the seams between them.
    let lobe = Shape::cylinder_at(v(30.0, 0.0, 0.0), DVec3::Z, 14.5, 7.0)
        .unwrap()
        .fuse(&Shape::box_from_corners(v(0.0, -6.0, 0.0), v(30.0, 6.0, 7.0)).unwrap())
        .unwrap();
    let part = Shape::cylinder(15.0, 7.0)
        .unwrap()
        .fuse(&lobe)
        .unwrap()
        .fuse(&lobe.rotate(DVec3::ZERO, DVec3::Z, 180.0).unwrap())
        .unwrap();
    let top = part.edges().farthest(DVec3::Z).unwrap();
    let cleaned = part.clean().unwrap();
    let clean_top = cleaned.edges().farthest(DVec3::Z).unwrap();
    assert!(top.len() > clean_top.len());
    // The seams are left out, as no corner, but OpenCASCADE can't round the edges that meet
    // them either: the fillet fails, saying to clean the shape first.
    err_contains(part.fillet(1.5, top.shapes()), "merge the faces with clean() first");
    err_contains(part.chamfer(0.5, top.shapes()), "can't bevel edges that meet those");
    // On the cleaned shape, with its edges selected there, both work.
    let volume = cleaned.volume().unwrap();
    let rounded = cleaned.fillet(1.5, clean_top.shapes()).unwrap();
    assert!(rounded.is_valid());
    assert!(rounded.volume().unwrap() < volume);
    let bevelled = cleaned.chamfer(0.5, clean_top.shapes()).unwrap();
    assert!(bevelled.is_valid());
    assert!(bevelled.volume().unwrap() < volume);

    // Seams alone leave nothing to round, and a radius too big for the faces fails; both say
    // what to try instead.
    let outline = Shape::compound(clean_top.shapes()).unwrap();
    let seams: Vec<Shape> = top
        .iter()
        .filter(|e| {
            let mid = Shape::vertex_at(e.point_at(0.5).unwrap()).unwrap();
            mid.distance(&outline).unwrap() > 1e-4
        })
        .cloned()
        .collect();
    assert!(!seams.is_empty());
    err_contains(part.fillet(1.0, &seams), "faces that continue each other: there is no corner");
    err_contains(cleaned.chamfer(30.0, clean_top.shapes()), "Try a smaller distance");
    err_contains(cube10().fillet(20.0, &[cube10().edges().first().unwrap()]), "the selected edge");
}

#[test]
fn fillets_leave_out_seams() {
    // A bridge saddle: a box under a large horizontal cylinder, whose seam runs along the top.
    let saddle = Shape::box_centered(72.0, 3.2, 11.0)
        .unwrap()
        .translate(v(0.0, 0.0, 5.5))
        .unwrap()
        .common(&Shape::cylinder_at(v(0.0, -5.0, -389.0), DVec3::Y, 400.0, 10.0).unwrap())
        .unwrap();
    let along_y = saddle.edges().parallel_to(DVec3::Y).unwrap();
    let seam = along_y.farthest(DVec3::Z).unwrap();
    assert_eq!(seam.len(), 1);
    let m = err(saddle.fillet(1.0, seam.shapes())).to_string();
    assert!(m.contains("all seams") && m.contains("Select the edges between faces"), "{m}");
    assert!(err(saddle.chamfer(0.5, seam.shapes())).to_string().contains("to bevel"));
    // With the seam among them, the real edges are still rounded.
    let rounded = saddle.fillet(1.0, along_y.shapes()).unwrap();
    assert!(rounded.is_valid());
    assert!(rounded.volume().unwrap() < saddle.volume().unwrap());
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

    // A box with rounded corners and a 1.5 mm fillet round its base, shelled 2.5 mm through the
    // top (a diecast enclosure): this failed with OpenCASCADE's default settings.
    let enclosure = Shape::box_centered(112.4, 60.5, 31.0).unwrap();
    let vertical = enclosure.edges().select("|Z").unwrap();
    let enclosure = enclosure.fillet(6.0, vertical.shapes()).unwrap();
    let base = enclosure.edges().select("<Z").unwrap();
    let enclosure = enclosure.fillet(1.5, base.shapes()).unwrap();
    let open = enclosure.faces().farthest(DVec3::Z).unwrap();
    let walls = enclosure.shell(-2.5, open.shapes()).unwrap();
    assert!(walls.is_valid());
    assert!(walls.volume().unwrap() < 0.5 * enclosure.volume().unwrap());
    // Walls thicker than the fillets they offset inward can't be made; OpenCASCADE returned
    // the box unchanged, or an invalid shape, as if it had worked.
    let rounded = Shape::box_centered(50.0, 30.0, 20.0).unwrap().fillet_all(1.0).unwrap();
    let open = rounded.faces().farthest(DVec3::Z).unwrap();
    err_contains(rounded.shell(-1.0, open.shapes()), "shell failed");
    err_contains(rounded.shell(-1.0, &[]), "shell failed");
    // A lofted duct can't be offset either; the error suggests subtracting an inside instead.
    let duct = Shape::loft(
        &[
            Shape::rect_on(&Plane::new(v(0.0, 0.0, 25.0), DVec3::Z).unwrap(), 20.0, 15.0).unwrap(),
            Shape::rect_on(&Plane::new(v(0.0, 4.0, 12.5), v(0.0, 0.3, 1.0)).unwrap(), 22.0, 9.0)
                .unwrap(),
            Shape::rect_on(&Plane::new(v(0.0, 12.0, 0.0), v(0.0, 1.0, 0.5)).unwrap(), 30.0, 3.0)
                .unwrap(),
        ],
        true,
    )
    .unwrap();
    let ends =
        duct.faces().farthest(DVec3::Z).unwrap().union(&duct.faces().farthest(DVec3::Y).unwrap());
    err_contains(duct.shell(-1.2, ends.shapes()), "subtract it");

    let square = Shape::rect_on(&Plane::xy(), 4.0, 4.0).unwrap();
    let grown = Shape::face_from(&square).unwrap().offset_2d(1.0).unwrap();
    assert_eq!(grown.shape_type(), ShapeType::Face);
    assert_close(grown.area().unwrap(), 16.0 + 16.0 + PI, 1e-6);
    let wire = square.offset_2d(1.0).unwrap();
    assert_eq!(wire.shape_type(), ShapeType::Wire);
    assert_close(wire.length().unwrap(), 16.0 + 2.0 * PI, 1e-6);
    let shrunk = square.offset_2d(-1.0).unwrap();
    assert_close(shrunk.length().unwrap(), 8.0, 1e-6);
    // A face keeps its holes: growing it shrinks a 4 x 4 hole in a 10 x 10 face to 2 x 2, and
    // shrinking it grows the hole to 6 x 6 with rounded corners.
    let outer = Shape::rect_on(&Plane::xy(), 10.0, 10.0).unwrap();
    let holed = Shape::face_with_holes(&outer, std::slice::from_ref(&square)).unwrap();
    let grown = holed.offset_2d(1.0).unwrap();
    assert_eq!(grown.wires().len(), 2);
    assert_close(grown.area().unwrap(), 140.0 + PI - 4.0, 1e-6);
    let shrunk = holed.offset_2d(-1.0).unwrap();
    assert_eq!(shrunk.wires().len(), 2);
    assert_close(shrunk.area().unwrap(), 64.0 - (32.0 + PI), 1e-6);
    // Two 4 x 4 squares joined by a bar 1 wide come apart when shrunk by more than 0.5.
    let dumbbell = [
        (-6.0, -2.0),
        (-2.0, -2.0),
        (-2.0, -0.5),
        (2.0, -0.5),
        (2.0, -2.0),
        (6.0, -2.0),
        (6.0, 2.0),
        (2.0, 2.0),
        (2.0, 0.5),
        (-2.0, 0.5),
        (-2.0, 2.0),
        (-6.0, 2.0),
    ]
    .map(|(x, y)| DVec2::new(x, y));
    let dumbbell = Shape::polygon_on(&Plane::xy(), &dumbbell).unwrap();
    err_contains(dumbbell.offset_2d(-0.75), "splits the shape into separate regions");
    err_contains(Shape::face_from(&dumbbell).unwrap().offset_2d(-0.75), "separate regions");
    assert_eq!(dumbbell.offset_2d(-0.25).unwrap().shape_type(), ShapeType::Wire);
    err_contains(cube.offset_2d(1.0), "expected wire, edge or face, got solid");
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
fn offsets_of_open_wires_and_tight_curves() {
    // An open wire grows into the outline around it: a slot around a line, with round ends.
    let slot = Shape::polyline(&[v(0.0, 0.0, 1.0), v(20.0, -10.0, 1.0)]).unwrap().offset_2d(5.0);
    let slot = Shape::face_from(&slot.unwrap()).unwrap();
    assert_close(slot.area().unwrap(), 10.0 * 500f64.sqrt() + 25.0 * PI, 1e-6);
    assert_vec_close(slot.normal().unwrap(), DVec3::Z, 1e-9);
    assert_close(slot.bounding_box().unwrap().max.z, 1.0, 1e-6);
    let edge = Shape::line(DVec3::ZERO, v(10.0, 0.0, 0.0)).unwrap();
    assert_close(
        Shape::face_from(&edge.offset_2d(1.0).unwrap()).unwrap().area().unwrap(),
        20.0 + PI,
        1e-6,
    );
    // Around a bend, the outline follows it.
    let bent = Shape::polyline(&[DVec3::ZERO, v(20.0, 0.0, 0.0), v(20.0, 10.0, 0.0)]).unwrap();
    let around = Shape::face_from(&bent.offset_2d(2.0).unwrap()).unwrap();
    assert_close(around.area().unwrap(), 120.0 + 4.0 * PI + PI - 4.0, 1e-6);
    err_contains(bent.offset_2d(-1.0), "its offset must be positive");
    let upright = Shape::polyline(&[DVec3::ZERO, v(0.0, 0.0, 10.0)]).unwrap();
    err_contains(
        upright.offset_2d(1.0),
        "a straight line that isn't horizontal lies in many planes",
    );

    // A closed spline with 12 lobes: offset by less than its tightest bends, it gives a valid
    // ring; offset further, OpenCASCADE's offset comes out crossing itself, which is an error.
    let lobes = |depth: f64| -> Shape {
        let points: Vec<DVec3> = (0..96)
            .map(|i| {
                let a = i as f64 * 2.0 * PI / 96.0;
                let r = 29.25 + depth * (12.0 * a).cos();
                v(r * a.cos(), r * a.sin(), 0.0)
            })
            .collect();
        Shape::wire_from(&[Shape::spline(&points, true).unwrap()]).unwrap()
    };
    let outline = lobes(0.75);
    for distance in [0.8, -0.8, 3.8, -3.8] {
        let offset = outline.offset_2d(distance).unwrap();
        let (outer, inner) = if distance > 0.0 { (&offset, &outline) } else { (&outline, &offset) };
        let ring = Shape::face_with_holes(outer, std::slice::from_ref(inner)).unwrap();
        assert!(ring.is_valid(), "{distance}");
        assert!(ring.extrude(v(0.0, 0.0, 1.5)).unwrap().is_valid(), "{distance}");
    }
    err_contains(lobes(1.5).offset_2d(3.8), "comes out crossing itself");
    err_contains(lobes(3.0).offset_2d(3.8), "comes out crossing itself");
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
    // A full cylinder's center lies on its axis, as near every point of its side as any other:
    // the side has no one normal there. Half of it has.
    err_contains(side.normal(), "there is no one normal there");
    let half =
        cylinder.cut(&Shape::box_from_corners(v(0.0, -2.0, -1.0), v(2.0, 2.0, 3.0)).unwrap());
    let side = half.unwrap().faces().of_type("cylinder").unwrap().single().unwrap();
    assert_vec_close(side.normal().unwrap(), DVec3::NEG_X, 1e-9);
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
