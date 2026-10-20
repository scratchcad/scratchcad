// Tangram set cut from a 100 mm square, 5 mm thick: two large triangles, one medium, two small, a square and a parallelogram, laid out with 2 mm gaps
let s = 100.0; // [60.0, 200.0] Square size (mm)
let t = 5.0; // [3.0, 10.0] Thickness (mm)
let h = s / 2.0;
let q = s / 4.0;
let pieces = [
    polygon([[0, 0], [s, 0], [h, h]]),
    polygon([[0, 0], [h, h], [0, s]]),
    polygon([[s, s], [s, h], [h, s]]),
    polygon([[h, h], [3.0 * q, q], [3.0 * q, 3.0 * q]]),
    polygon([[0, s], [q, 3.0 * q], [h, s]]),
    polygon([[h, h], [3.0 * q, 3.0 * q], [h, s], [q, 3.0 * q]]),
    polygon([[3.0 * q, q], [s, 0], [s, h], [3.0 * q, 3.0 * q]])
];
let solids = [];
for p in pieces {
    let f = p.to_face();
    let c = f.center();
    solids.push(f.extrude(t).translate([c.x * 0.04, c.y * 0.04, 0]));
}
compound(solids)
