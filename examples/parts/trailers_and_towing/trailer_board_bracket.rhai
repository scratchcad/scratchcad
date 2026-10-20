// Trailer lighting board bracket: hooks over a 6 mm tailboard edge, 30 mm wide, 3 mm steel, 25 mm hook and a 60 mm drop leg with an 8.5 mm wing-bolt hole
let board = 6.0; // [3.0, 25.0] Tailboard thickness (mm)
let drop = 60.0; // [40.0, 100.0] Drop leg length (mm)
const t = 3.0;
const w = 30.0;
let top = box_from_corners([0, 0, 0], [board + 2.0 * t, w, t]);
let front = box_from_corners([0, 0, -25.0], [t, w, 0.01]);
let back = box_from_corners([board + t, 0, -drop], [board + 2.0 * t, w, 0.01]);
top + front + back - cylinder([board, w / 2.0, -drop + 15.0], "X", 4.25, 3.0 * t)
