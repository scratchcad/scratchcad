// Reservoir float switch side mount: 4 mm thick angle bracket 30 mm wide, an upright 100 mm tall with a 6 mm height-adjust slot 60 mm long, a 35 mm foot with a 16.5 mm hole for an M16 horizontal float switch stem, and two 3 mm triangular gussets
let upright_h = 100.0; // [60.0, 160.0] Upright height (mm)
let foot_len = 35.0; // [28.0, 50.0] Foot length (mm)
let switch_hole = 16.5; // [8.5, 20.0] Switch stem hole diameter (mm)
let slot_len = 60.0; // [20.0, 100.0] Adjust slot length (mm)
const t = 4.0;
const w = 30.0;
const gt = 3.0;
let up = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, t, upright_h]);
let up = up.fillet(5.0, up.edges("|Y and >Z"));
let foot = box_from_corners([-w / 2.0, -foot_len, 0], [w / 2.0, 0.5, t]);
let foot = foot.fillet(5.0, foot.edges("|Z and <Y"));
let gl = min(20.0, foot_len - switch_hole - 6.0);
let gl = max(gl, 6.0);
let gussets = [];
for s in [-1.0, 1.0] {
    let x = s * (w / 2.0 - gt / 2.0);
    gussets.push(face(polygon([[x - gt / 2.0, 0.5, t - 0.5], [x - gt / 2.0, -gl, t - 0.5], [x - gt / 2.0, 0.5, t + gl]])).extrude([gt, 0, 0]));
}
let body = fuse_all([up, foot] + gussets);
let sl = min(slot_len, upright_h - 30.0);
let hr = min(switch_hole / 2.0, w / 2.0 - gt - 2.0);
let cuts = [
    cylinder([0, -foot_len + hr + 4.0, -1.0], "Z", hr, t + 2.0),
    cylinder([0, -1.0, upright_h - 12.0], "Y", 3.0, t + 2.0),
    cylinder([0, -1.0, upright_h - 12.0 - sl], "Y", 3.0, t + 2.0),
    box_from_corners([-3.0, -1.0, upright_h - 12.0 - sl], [3.0, t + 1.0, upright_h - 12.0])
];
body - fuse_all(cuts)
