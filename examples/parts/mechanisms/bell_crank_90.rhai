// 90 degree bell crank: 40 mm and 30 mm arms, 8 mm pivot, 4 mm link holes, 5 mm plate
let arm_a = 40.0; // [20.0, 80.0] Arm A (mm)
let arm_b = 30.0; // [15.0, 60.0] Arm B (mm)
let t = 5.0; // [3.0, 10.0] Thickness (mm)
let w = 10.0; // [6.0, 16.0] Arm width (mm)
let a = box_from_corners([0, -w / 2.0, 0], [arm_a, w / 2.0, t]) + cylinder([arm_a, 0, 0], "Z", w / 2.0, t);
let b = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, arm_b, t]) + cylinder([0, arm_b, 0], "Z", w / 2.0, t);
let hub = cylinder(w * 0.8, t);
let web = polygon([[w / 2.0, w / 2.0], [arm_a * 0.45, w / 2.0], [w / 2.0, arm_b * 0.45]]).to_face().extrude([0, 0, t]);
a + b + hub + web - cylinder([0, 0, -1], "Z", 4.0, t + 2.0) - cylinder([arm_a, 0, -1], "Z", 2.0, t + 2.0) - cylinder([0, arm_b, -1], "Z", 2.0, t + 2.0)
