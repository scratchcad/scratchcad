// Hive frame rest rail: 410 mm, 0.8 mm folded L 10 x 12 mm with a 3 mm top bead
let length = 410.0; // [300.0, 500.0] Length (mm)
let t = 0.8; // [0.5, 1.5] Sheet thickness (mm)
let a = box_from_corners([0, 0, 0], [length, 12.0, t]) + box_from_corners([0, 12.0 - t, 0], [length, 12.0, 10.0]) + cylinder([0, 12.0 - t / 2.0, 10.0], "X", 1.5, length);
a
