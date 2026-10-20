// Outboard choke pull knob: 25 mm mushroom knob 15 mm tall with sixteen 1.5 mm grip flutes, 1.5 mm top chamfer, a 12 mm neck 6 mm long, and a 5 mm D bore (4.3 mm across the flat) 14 mm deep for the choke rod
let knob_d = 25.0; // [18.0, 35.0] Knob diameter (mm)
let knob_h = 15.0; // [10.0, 22.0] Knob height (mm)
let rod_d = 5.0; // [3.0, 8.0] Choke rod diameter (mm)
const neck_len = 6.0;
const neck_d = 12.0;
let r = knob_d / 2.0;
let head = cylinder([0, 0, neck_len], "Z", r, knob_h - neck_len);
let head = head.chamfer(1.5, head.edges(">Z"));
let neck = cylinder([0, 0, 0], "Z", max(neck_d / 2.0, rod_d / 2.0 + 2.0), neck_len + 0.5);
let body = head + neck;
let cuts = [];
for i in 0..16 {
    cuts.push(cylinder([r + 0.3, 0, neck_len - 1.0], "Z", 1.5, knob_h - neck_len - 1.5).rotate_z(i.to_float() * 22.5));
}
let bore = cylinder([0, 0, -1.0], "Z", rod_d / 2.0, min(14.0, knob_h - 1.5) + 1.0) - box_from_corners([rod_d / 2.0 - 0.7, -rod_d, -2.0], [rod_d, rod_d, knob_h]);
body - fuse_all(cuts) - bore
