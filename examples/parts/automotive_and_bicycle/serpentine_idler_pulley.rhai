// Smooth serpentine idler pulley: 70 mm OD, 26 mm belt face between 2 mm flanges, 40 mm bore for a 6203 bearing, six lightening holes
let od = 70.0; // [60.0, 90.0] Outer diameter (mm)
let face = 26.0; // [20.0, 32.0] Belt face width (mm)
let r = od / 2.0;
let rim = cylinder(r, face) - cylinder([0, 0, -1], "Z", r - 3.0, face + 2.0);
let flange = cylinder(r + 2.0, 2.0) - cylinder([0, 0, -1], "Z", r - 3.0, 4.0);
let web = cylinder([0, 0, face / 2.0 - 3.0], "Z", r - 2.0, 6.0);
let hub = cylinder([0, 0, face / 2.0 - 7.0], "Z", 24.0, 14.0);
let p = fuse_all([rim, flange.translate([0, 0, -2.0]), flange.translate([0, 0, face]), web, hub]) - cylinder([0, 0, -5], "Z", 20.0, face + 10.0);
for k in 0..6 { p -= cylinder([(24.0 + r - 3.0) / 2.0, 0, -5], "Z", 3.5, face + 10.0).rotate("Z", k.to_float() * 60.0); }
p
