// 2207 brushless outrunner: 27.9 mm bell 18 mm tall with six vent holes, 5 mm shaft, 7 mm base with 16 x 16 mm M3 holes
let od = 27.9; // [24.0, 34.0] Bell diameter (mm)
let bell_h = 18.0; // [12.0, 24.0] Bell height (mm)
let r = od / 2.0;
let top = 7.5 + bell_h;
let base = cylinder(r - 0.5, 7.0);
for x in [-8.0, 8.0] { for y in [-8.0, 8.0] { base -= cylinder([x, y, -1], "Z", 1.5, 5.0); } }
let bell = cylinder([0, 0, 7.5], "Z", r, bell_h) - cylinder([0, 0, 7.0], "Z", r - 1.0, bell_h - 1.5);
for k in 0..6 { bell -= cylinder([r * 0.6, 0, top - 3.0], "Z", 2.8, 5.0).rotate("Z", k.to_float() * 60.0); }
let shaft = cylinder([0, 0, 6.0], "Z", 2.5, bell_h + 12.0);
fuse_all([base, bell, shaft])
