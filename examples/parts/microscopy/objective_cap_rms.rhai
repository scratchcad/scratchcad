// RMS objective thread cap: 20.32 mm (0.8 in) thread bore 4 mm deep, 24 mm OD knurled, 6 mm tall
let bore = 20.32; // [20.0, 26.0] Thread diameter (mm)
let height = 6.0; // [4.0, 10.0] Height (mm)
let od = 24.0; // [22.0, 30.0] Outside diameter (mm)
let c = cylinder(od / 2.0, height) - cylinder([0, 0, 1.5], "Z", bore / 2.0, height);
let knurl = [];
for k in 0..30 { knurl.push(cylinder([od / 2.0 + 0.2, 0, -1], "Z", 0.5, height + 2.0).rotate_z(k.to_float() * 12.0)); }
c - compound(knurl)
