// Limit switch roller lever arm: 38 mm arm 3 mm, 6 mm square drive hole, 19 mm roller fork 7 mm with 4 mm axle hole
let arm = 38.0; // [25.0, 60.0] Arm length (mm)
let t = 3.0; // [2.0, 5.0] Arm thickness (mm)
let roller = 7.0; // [5.0, 10.0] Roller width (mm)
let hub = cylinder(7.0, t + 6.0);
let a = box_from_corners([0, -4.0, 0], [arm, 4.0, t]);
let fork = box_from_corners([arm - 8.0, -roller / 2.0 - 2.5, 0], [arm + 6.0, roller / 2.0 + 2.5, t]) + box_from_corners([arm - 2.0, -roller / 2.0 - 2.5, 0], [arm + 6.0, -roller / 2.0, 14.0]) + box_from_corners([arm - 2.0, roller / 2.0, 0], [arm + 6.0, roller / 2.0 + 2.5, 14.0]);
hub + a + fork - box_centered(6.0, 6.0, 30.0) - cylinder([arm + 2.0, -10.0, 10.0], "Y", 2.0, 20.0)
