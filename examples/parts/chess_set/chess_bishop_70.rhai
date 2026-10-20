// Staunton-style chess bishop: 70 mm tall, 32 mm base, revolved straight-segment profile with a collar, a 22 mm mitre with a 2.5 mm diagonal slit and a 9 mm finial ball
let height = 70.0; // [50.0, 90.0] Bishop height (mm)
let base = 32.0; // [24.0, 40.0] Base diameter (mm)
let s = height / 70.0;
let b = base / 2.0;
let prof = polygon([[0, 0, 0], [b, 0, 0], [b, 0, 4.0 * s], [b - 2.0, 0, 7.0 * s], [b - 3.5, 0, 10.0 * s], [6.0 * s, 0, 18.0 * s], [5.0 * s, 0, 36.0 * s], [10.0 * s, 0, 38.0 * s], [10.0 * s, 0, 40.0 * s], [6.0 * s, 0, 42.0 * s], [10.0 * s, 0, 50.0 * s], [9.0 * s, 0, 56.0 * s], [3.0 * s, 0, 62.0 * s], [0, 0, 62.0 * s]]);
let body = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let finial = sphere([0, 0, 65.5 * s], 4.5 * s);
let slit = box_centered(30.0 * s, 2.5 * s, 14.0 * s).rotate_y(40.0).translate([3.0 * s, 0, 54.0 * s]);
body + finial - slit - cylinder([0, 0, -1.0], "Z", b - 4.5, 2.0)
