// Staunton-style chess rook: 57 mm tall, 33 mm base, straight-segment revolved profile, 22 mm turret with 5 crenels 5 mm wide 5 mm deep and a 12 mm top recess
let height = 57.0; // [40.0, 75.0] Rook height (mm)
let base = 33.0; // [25.0, 42.0] Base diameter (mm)
let s = height / 57.0;
let b = base / 2.0;
let prof = polygon([[0, 0, 0], [b, 0, 0], [b, 0, 4.0 * s], [b - 2.0, 0, 7.0 * s], [b - 3.5, 0, 10.0 * s], [8.0 * s, 0, 16.0 * s], [8.0 * s, 0, 40.0 * s], [11.0 * s, 0, 44.0 * s], [11.0 * s, 0, 57.0 * s], [0, 0, 57.0 * s]]);
let body = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let cuts = [cylinder([0, 0, 52.0 * s], "Z", 6.0 * s, 10.0)];
for i in 0..5 { cuts.push(box_from_corners([0, -2.5 * s, 52.0 * s], [15.0 * s, 2.5 * s, 60.0 * s]).rotate_z(i.to_float() * 72.0)); }
body - fuse_all(cuts) - cylinder([0, 0, -1.0], "Z", b - 4.5, 2.0)
