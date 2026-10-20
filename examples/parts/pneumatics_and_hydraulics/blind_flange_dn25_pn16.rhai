// EN 1092-1 DN25 PN16 blind flange: 115 mm OD, 18 mm thick, 4 x 14 mm holes on 85 mm PCD, 68 mm raised face 2 mm
let od = 115.0; // [90.0, 220.0] Outside diameter (mm)
let t = 18.0; // [12.0, 30.0] Thickness (mm)
let pcd = 85.0; // [60.0, 180.0] Bolt circle (mm)
let hole = 14.0; // [11.0, 22.0] Bolt hole (mm)
let rf = 68.0; // [40.0, 160.0] Raised face diameter (mm)
let f = cylinder(od / 2.0, t) + cylinder([0, 0, t - 0.01], "Z", rf / 2.0, 2.0);
let holes = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([pcd / 2.0 * a.cos(), pcd / 2.0 * a.sin(), -1], "Z", hole / 2.0, t + 4.0)); }
f - compound(holes)
