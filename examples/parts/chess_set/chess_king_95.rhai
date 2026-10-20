// Staunton-style chess king: 95 mm tall tournament size, 40 mm base, revolved straight-segment profile, 22 mm crown and a 14 x 14 x 4 mm cross finial
let height = 95.0; // [70.0, 110.0] King height (mm)
let base = 40.0; // [30.0, 50.0] Base diameter (mm)
let s = height / 95.0;
let b = base / 2.0;
let prof = polygon([[0, 0, 0], [b, 0, 0], [b, 0, 5.0 * s], [b - 2.0, 0, 8.0 * s], [b - 4.0, 0, 12.0 * s], [7.5 * s, 0, 24.0 * s], [6.0 * s, 0, 54.0 * s], [11.0 * s, 0, 56.0 * s], [11.0 * s, 0, 58.0 * s], [6.5 * s, 0, 60.0 * s], [11.0 * s, 0, 74.0 * s], [11.0 * s, 0, 78.0 * s], [4.0 * s, 0, 81.0 * s], [0, 0, 81.0 * s]]);
let body = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let cross = box_centered(4.0 * s, 4.0 * s, 15.0 * s).translate([0, 0, 87.5 * s - 0.5 * s]) + box_centered(12.0 * s, 4.0 * s, 4.0 * s).translate([0, 0, 89.0 * s]);
body + cross - cylinder([0, 0, -1.0], "Z", b - 5.0, 2.0)
