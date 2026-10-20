// Checkers piece: 32 mm disc 8 mm thick with ridged edge, stacking recess underneath and crown boss on top
let d = 32.0; // [25.0, 40.0] Diameter (mm)
let r = d / 2.0;
let p = cylinder(r, 8.0).chamfer(0.6, "%CIRCLE") - cylinder([0, 0, -1.0], "Z", r - 3.0, 2.5) + cylinder([0, 0, 7.9], "Z", r - 3.1, 1.5);
let ridges = [];
for k in 0..36 { ridges.push(cylinder([r + 0.15, 0, 1.0], "Z", 0.5, 6.0).rotate("Z", k.to_float() * 10.0)); }
p - fuse_all(ridges) - torus(r * 0.55, 0.6).translate([0, 0, 9.4])
