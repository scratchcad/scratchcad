// 90 degree corner clamping square: two 80 mm arms 20 x 20 mm, 8 mm glue-relief hole in the inside corner, 20 x 8 mm clamp slot in each arm
let arm_l = 80.0; // [50.0, 150.0] Arm length (mm)
let arm_w = 20.0; // [15.0, 30.0] Arm width (mm)
let height = 20.0; // [12.0, 40.0] Height (mm)
let relief_d = 8.0; // [4.0, 12.0] Corner relief hole (mm)
let a1 = box_from_corners([0, 0, 0], [arm_l, arm_w, height]);
let a2 = box_from_corners([0, 0, 0], [arm_w, arm_l, height]);
let p = a1 + a2;
let slot_w = arm_w * 0.4;
let cuts = [
    cylinder([arm_w, arm_w, -1], "Z", relief_d / 2.0, height + 2.0),
    box_from_corners([arm_l * 0.5, arm_w / 2.0 - slot_w / 2.0, -1], [arm_l * 0.5 + 20.0, arm_w / 2.0 + slot_w / 2.0, height + 1.0]),
    box_from_corners([arm_w / 2.0 - slot_w / 2.0, arm_l * 0.5, -1], [arm_w / 2.0 + slot_w / 2.0, arm_l * 0.5 + 20.0, height + 1.0])
];
p - compound(cuts)
