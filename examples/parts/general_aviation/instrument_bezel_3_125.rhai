// 3 1/8 in panel instrument mounting bezel: 82.5 mm cut-out ring, 92 mm square flange 2 mm, 4 x #6 holes on 85.7 mm
let cutout = 82.5; // [57.0, 83.0] Instrument diameter (mm)
let flange = 92.0; // [65.0, 100.0] Flange size (mm)
let hole_pitch = 85.7; // [60.0, 90.0] Diagonal hole spacing (mm)
let t = 2.0; // [1.5, 3.0] Flange thickness (mm)
let f = box_centered(flange, flange, t).translate([0, 0, t / 2.0]);
let ff = f.fillet(8.0, f.edges("|Z"));
let lip = cylinder([0, 0, t - 0.01], "Z", cutout / 2.0 + 2.0, 3.0);
let holes = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([hole_pitch / 2.0 * a.cos(), hole_pitch / 2.0 * a.sin(), -1], "Z", 1.8, t + 2.0)); }
ff + lip - cylinder([0, 0, -1], "Z", cutout / 2.0, t + 5.0) - compound(holes)
