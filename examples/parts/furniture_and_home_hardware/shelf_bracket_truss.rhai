// Steel shelf bracket: 200 mm upright and 150 mm arm, 30 mm wide 3 mm flat bar, open triangular gusset, two 5 mm holes each leg
let arm = 150.0; // [100.0, 300.0] Arm length (mm)
let up = 200.0; // [120.0, 350.0] Upright length (mm)
let w = 30.0; // [20.0, 50.0] Width (mm)
let upright = box_from_corners([0, -w / 2.0, 0], [3.0, w / 2.0, up]);
let shelf = box_from_corners([0, -w / 2.0, up - 3.0], [arm, w / 2.0, up]);
let tri = polygon([[3, 0, up - 3.0], [arm * 0.66, 0, up - 3.0], [3, 0, up - arm * 0.66]]);
let inner = polygon([[9, 0, up - 9.0], [arm * 0.66 - 15.0, 0, up - 9.0], [9, 0, up - arm * 0.66 + 15.0]]);
let gusset = (tri.to_face() - inner.to_face()).extrude([0, 3.0, 0]).translate([0, -1.5, 0]);
let b = fuse_all([upright, shelf, gusset]);
for z in [30.0, up - 30.0] { b -= cylinder([-1, 0, z], "X", 2.5, 5.0); }
for x in [50.0, arm - 30.0] { b -= cylinder([x, 0, up - 4.0], "Z", 2.5, 5.0); }
b
