// SG90 cross servo horn: 21-spline hub 7 mm, four arms 32 mm tip to tip, 1 mm holes at 1.5 mm pitch
let span = 32.0; // [20.0, 50.0] Arm span (mm)
let hub_d = 7.0; // [5.0, 10.0] Hub diameter (mm)
let thickness = 1.5; // [1.0, 3.0] Arm thickness (mm)
let hub_h = 4.0; // [2.5, 6.0] Hub height (mm)
let arm = loft([rect(plane([0, 0, 0], "X", "Y"), 5.0, thickness), rect(plane([span / 2.0, 0, 0], "X", "Y"), 3.0, thickness)], true).translate([0, 0, thickness / 2.0]);
let horn = fuse_all([cylinder(hub_d / 2.0, hub_h), arm, arm.rotate_z(90), arm.rotate_z(180), arm.rotate_z(270)]);
let holes = [];
for i in 0..4 { for k in 0..4 { holes.push(cylinder([span / 2.0 - 1.5 - k.to_float() * 1.5 * 1.3, 0, -1], "Z", 0.5, 4.0).rotate_z(i * 90)); } }
horn - fuse_all(holes) - cylinder([0, 0, -1], "Z", 2.4, hub_h - 0.5) - cylinder([0, 0, -1], "Z", 1.1, hub_h + 2.0)
