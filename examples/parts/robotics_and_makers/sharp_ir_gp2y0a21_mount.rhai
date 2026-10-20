// Angle mount for a Sharp GP2Y0A21YK IR distance sensor: 2 mm upright 44 x 16 mm with two 3.2 mm holes 37 mm apart and a 30 x 9 mm lens window, 15 mm base with an M3 slot, 2 gussets
let hole_spacing = 37.0; // [30.0, 45.0] Sensor hole spacing (mm)
let face_w = 44.0; // [40.0, 55.0] Upright width (mm)
let face_h = 16.0; // [14.0, 25.0] Upright height (mm)
let base_d = 15.0; // [10.0, 25.0] Base depth (mm)
const t = 2.0;
let hs = min(hole_spacing, face_w - 6.0);
let up = box_from_corners([-face_w / 2.0, -t, 0], [face_w / 2.0, 0, face_h + t]);
up -= box_centered(30.0, 4.0, 9.0).translate([0, -t / 2.0, t + face_h * 0.55]).fillet(1.0, "|Y");
for s in [-1.0, 1.0] { up -= cylinder([s * hs / 2.0, -t - 1.0, t + face_h * 0.55], "Y", 1.6, t + 2.0); }
let base = box_from_corners([-12.0, -t + 0.01, 0], [12.0, base_d, t]);
let g = [];
for s in [-1.0, 1.0] { g.push(polygon("YZ", [[-0.01, t - 0.01], [base_d * 0.7, t - 0.01], [-0.01, face_h * 0.6]]).to_face().extrude([1.6, 0, 0]).translate([s * 11.0 - 0.8, 0, 0])); }
let m = fuse_all([up, base] + g);
m - (box_centered(6.0, 3.4, 10.0).translate([0, base_d * 0.6, 0]) + cylinder([-3.0, base_d * 0.6, -1], "Z", 1.7, 6.0) + cylinder([3.0, base_d * 0.6, -1], "Z", 1.7, 6.0))
