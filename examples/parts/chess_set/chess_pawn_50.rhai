// Staunton-style chess pawn: 50 mm tall, 29 mm base, faceted straight-segment profile (base, collar, stem), 20 mm ball head and a 20 mm felt recess 1 mm deep underneath
let height = 50.0; // [35.0, 65.0] Pawn height (mm)
let base = 29.0; // [22.0, 38.0] Base diameter (mm)
let s = height / 50.0;
let b = base / 2.0;
let prof = polygon([[0, 0, 0], [b, 0, 0], [b, 0, 4.0 * s], [b - 2.0, 0, 6.0 * s], [b - 3.0, 0, 9.0 * s], [6.0 * s, 0, 14.0 * s], [5.0 * s, 0, 26.0 * s], [9.0 * s, 0, 28.0 * s], [9.0 * s, 0, 30.0 * s], [4.0 * s, 0, 32.0 * s], [0, 0, 32.0 * s]]);
let body = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let head = sphere([0, 0, 40.0 * s], 10.0 * s);
body + head - cylinder([0, 0, -1.0], "Z", b - 4.5, 2.0)
