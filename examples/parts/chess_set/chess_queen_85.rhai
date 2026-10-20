// Staunton-style chess queen: 85 mm tall, 37 mm base, revolved straight-segment profile, flared 24 mm coronet with 8 crown points and a 10 mm ball finial
let height = 85.0; // [60.0, 105.0] Queen height (mm)
let base = 37.0; // [28.0, 46.0] Base diameter (mm)
let s = height / 85.0;
let b = base / 2.0;
let prof = polygon([[0, 0, 0], [b, 0, 0], [b, 0, 5.0 * s], [b - 2.0, 0, 8.0 * s], [b - 4.0, 0, 12.0 * s], [7.0 * s, 0, 22.0 * s], [5.5 * s, 0, 50.0 * s], [10.0 * s, 0, 52.0 * s], [10.0 * s, 0, 54.0 * s], [6.0 * s, 0, 56.0 * s], [12.0 * s, 0, 72.0 * s], [12.0 * s, 0, 76.0 * s], [0, 0, 76.0 * s]]);
let body = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let notches = [];
for i in 0..8 { notches.push(cone(3.0 * s, 0.5 * s, 5.0 * s).rotate_x(180.0).translate([12.0 * s, 0, 76.5 * s]).rotate_z(i.to_float() * 45.0 + 22.5)); }
let finial = sphere([0, 0, 80.0 * s], 5.0 * s);
body - fuse_all(notches) + finial - cylinder([0, 0, -1.0], "Z", b - 5.0, 2.0)
