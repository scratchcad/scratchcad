// EN 1092-1 DN50 PN16 blind flange: 165 mm OD, 18 mm thick, 4 x 18 mm holes on 125 mm PCD, 102 mm raised face 2 mm
let outer_d = 165.0; // [95.0, 340.0] Outside diameter (mm)
let thickness = 18.0; // [14.0, 30.0] Thickness (mm)
let pcd = 125.0; // [65.0, 295.0] Bolt circle (mm)
let holes = 4; // [4, 12] Bolt holes
let hole_d = 18.0; // [14.0, 26.0] Hole diameter (mm)
let rf_d = 102.0; // [45.0, 268.0] Raised face diameter (mm)
let flange = cylinder(outer_d / 2.0, thickness) + cylinder([0, 0, thickness - 0.01], "Z", rf_d / 2.0, 2.01);
for i in 0..holes { flange -= cylinder([pcd / 2.0, 0, -1], "Z", hole_d / 2.0, thickness + 2.0).rotate_z((i.to_float() + 0.5) * 360.0 / holes.to_float()); }
flange
