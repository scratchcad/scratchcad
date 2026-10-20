// Tangram puzzle set: the 7 classic pieces cut from a 100 mm square 5 mm thick (2 large, 1 medium and 2 small triangles, a square and a parallelogram), laid out with 2 mm gaps (7 bodies)
let size = 100.0; // [60.0, 160.0] Square size (mm)
let t = 5.0; // [3.0, 10.0] Piece thickness (mm)
let s = size;
let q = s / 4.0;
const g = 2.0;

fn tri(pts, t) { face(polygon(pts)).extrude([0, 0, t]) }
let pieces = [
    tri([[0, 0, 0], [s, 0, 0], [s / 2.0, s / 2.0, 0]], t),
    tri([[0, 0, 0], [s / 2.0, s / 2.0, 0], [0, s, 0]], t).translate([-g, g, 0]),
    tri([[s, 0, 0], [s, s / 2.0, 0], [3.0 * q, q, 0]], t).translate([g, g, 0]),
    tri([[s / 2.0, s / 2.0, 0], [3.0 * q, q, 0], [3.0 * q, 3.0 * q, 0]], t).translate([g * 0.5, g * 2.0, 0]),
    tri([[0, s, 0], [s / 2.0, s, 0], [q, 3.0 * q, 0]], t).translate([-g, g * 2.5, 0]),
    tri([[s / 2.0, s / 2.0, 0], [3.0 * q, 3.0 * q, 0], [s / 2.0, s, 0], [q, 3.0 * q, 0]], t).translate([0, g * 3.0, 0]),
    tri([[s, s / 2.0, 0], [s, s, 0], [s / 2.0, s, 0], [3.0 * q, 3.0 * q, 0]], t).translate([g * 2.0, g * 3.0, 0])
];
compound(pieces)
