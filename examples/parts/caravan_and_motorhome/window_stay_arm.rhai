// Caravan window friction stay arm: 150 mm flat arm 16 x 4 mm with 8 mm rounded ends, a 5 mm pivot hole at one end and a 6 x 60 mm slide slot with 5 detent notches
let length = 150.0; // [100.0, 220.0] Arm length (mm)
let slot_l = 60.0; // [40.0, 100.0] Slot length (mm)
const w = 16.0;
const t = 4.0;
let arm = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, t]) + cylinder([0, 0, 0], "Z", w / 2.0, t) + cylinder([length, 0, 0], "Z", w / 2.0, t);
let slot = box_from_corners([length - slot_l - 8.0, -3.0, -1.0], [length - 8.0, 3.0, t + 1.0]);
let notches = [];
for i in 0..5 { notches.push(cylinder([length - slot_l - 8.0 + (i.to_float() + 0.5) * slot_l / 5.0, 3.0, -1.0], "Z", 1.5, t + 2.0)); }
arm - cylinder([0, 0, -1.0], "Z", 2.5, t + 2.0) - slot - fuse_all(notches)
