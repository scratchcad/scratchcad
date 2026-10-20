// Fertilizer spreader spinner vane: 180 mm angle-section vane, a 30 mm base flange 4 mm thick with two 8.5 mm bolt holes 100 mm apart, and a 4 mm upright web rising from 15 mm at the hub end to 35 mm at the tip, with the tip corner cut back 10 mm at 45 degrees
let length = 180.0; // [120.0, 260.0] Vane length (mm)
let flange_w = 30.0; // [22.0, 40.0] Base flange width (mm)
let root_h = 15.0; // [10.0, 25.0] Web height at the hub (mm)
let tip_h = 35.0; // [20.0, 50.0] Web height at the tip (mm)
let bolt_pitch = 100.0; // [60.0, 160.0] Bolt spacing (mm)
const t = 4.0;
const bolt_d = 8.5;
const chamfer = 10.0;
let th = max(tip_h, chamfer + 6.0);
let flange = box_from_corners([0, 0, 0], [length, flange_w, t]);
let web = polygon([[0, 0, 0], [length, 0, 0], [length, 0, th - chamfer], [length - chamfer, 0, th], [0, 0, root_h]]).to_face().extrude([0, t, 0]);
let vane = flange + web;
let bp = min(bolt_pitch, length - 30.0);
const x0 = 15.0;
vane - fuse_all([
    cylinder([x0, flange_w / 2.0 + t / 2.0, -1.0], "Z", bolt_d / 2.0, t + 2.0),
    cylinder([x0 + bp, flange_w / 2.0 + t / 2.0, -1.0], "Z", bolt_d / 2.0, t + 2.0),
])
