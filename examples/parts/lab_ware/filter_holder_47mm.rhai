// 47 mm membrane filter holder: base with a perforated support screen and 8 mm outlet stem, separate 250 ml funnel collar with sealing ring
let d = 47.0; // [25.0, 90.0] Filter diameter (mm)
let r = d / 2.0;
let base = cylinder(r + 6.0, 12.0) - cylinder([0, 0, 8.0], "Z", r, 5.0) - cone(3.0, r - 2.0, 6.0).translate([0, 0, 2.0]);
let screen = cylinder([0, 0, 7.0], "Z", r - 1.0, 1.0);
for i in 0..8 { for j in 0..8 { let x = (i.to_float() - 3.5) * 4.5; let y = (j.to_float() - 3.5) * 4.5; if x * x + y * y < (r - 3.0) * (r - 3.0) { screen -= cylinder([x, y, 6.0], "Z", 1.0, 3.0); } } }
let stem = cylinder([0, 0, -30.0], "Z", 4.0, 30.1) - cylinder([0, 0, -31.0], "Z", 2.5, 34.0);
let collar = cylinder([0, 0, 15.0], "Z", r + 6.0, 10.0) + cylinder([0, 0, 25.0], "Z", r + 15.0, 70.0) - cylinder([0, 0, 14.0], "Z", r - 1.0, 13.0) - cylinder([0, 0, 27.0], "Z", r + 13.5, 80.0) + torus(r + 1.0, 1.2).translate([0, 0, 14.4]);
compound([fuse_all([base, screen, stem]), collar])
