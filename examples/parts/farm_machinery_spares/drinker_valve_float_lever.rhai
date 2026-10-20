// Livestock drinker valve float lever: 120 mm arm 14 mm deep and 8 mm thick, a 16 mm pivot boss 14 mm wide at one end with a 5.2 mm pin hole, a 10 mm valve pad 3 mm proud 18 mm from the pivot to press the plunger, and a 16 mm boss at the far end with a 6.8 mm tapping hole for the M8 float rod
let arm_len = 120.0; // [80.0, 200.0] Arm length (mm)
let arm_h = 14.0; // [10.0, 20.0] Arm depth (mm)
let arm_t = 8.0; // [6.0, 12.0] Arm thickness (mm)
let pad_offset = 18.0; // [12.0, 30.0] Valve pad distance from pivot (mm)
let pin_d = 5.2; // [4.0, 8.2] Pivot pin hole (mm)
const boss_d = 16.0;
const boss_w = 14.0;
const pad_d = 10.0;
const pad_h = 3.0;
const tap = 6.8;
let rb = max(boss_d / 2.0, pin_d / 2.0 + 3.0);
let arm = box_from_corners([0, -arm_t / 2.0, -arm_h / 2.0], [arm_len, arm_t / 2.0, arm_h / 2.0]);
let pivot = cylinder([0, -boss_w / 2.0, 0], "Y", rb, boss_w);
let tip = cylinder([arm_len, 0, -arm_h / 2.0], "Z", boss_d / 2.0, arm_h);
let pad = cylinder([pad_offset, 0, -arm_h / 2.0 - pad_h], "Z", pad_d / 2.0, pad_h + 0.5);
let lever = fuse_all([arm, pivot, tip, pad]);
lever - fuse_all([
    cylinder([0, -boss_w / 2.0 - 1.0, 0], "Y", pin_d / 2.0, boss_w + 2.0),
    cylinder([arm_len, 0, -arm_h / 2.0 - 1.0], "Z", tap / 2.0, arm_h + 2.0),
])
