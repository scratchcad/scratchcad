// Bench wire strip-length gauge: 100 x 20 x 6 mm with notches at 5, 7, 10, 12 and 15 mm and AWG holes 0.5 to 2.0 mm
let length = 100.0; // [60.0, 150.0] Length (mm)
let width = 20.0; // [15.0, 30.0] Width (mm)
let t = 6.0; // [3.0, 10.0] Thickness (mm)
let bar = box_from_corners([0, 0, 0], [length, width, t]);
let b = bar.fillet(2.0, bar.edges("|Z"));
let notches = [];
let pos = [8.0, 22.0, 38.0, 56.0, 76.0];
let lens = [5.0, 7.0, 10.0, 12.0, 15.0];
for i in 0..5 { notches.push(box_from_corners([pos[i], -1, t - 2.5], [pos[i] + 1.2, lens[i], t + 1.0])); }
let holes = [];
let ds = [0.5, 0.8, 1.0, 1.3, 1.6, 2.0];
for i in 0..6 { holes.push(cylinder([10.0 + i.to_float() * 14.0, width - 4.0, -1], "Z", ds[i] / 2.0 + 0.05, t + 2.0)); }
b - compound(notches) - compound(holes)
