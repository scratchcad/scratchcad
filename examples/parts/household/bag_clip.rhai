// Chip bag clip: 100 mm long, two 8 x 6 mm arms joined by a C-hinge, interlocking hook at the tip
let length = 100.0; // [60.0, 160.0] Length (mm)
let arm_w = 8.0; // [5.0, 12.0] Arm width (mm)
let arm_t = 3.0; // [2.0, 5.0] Arm thickness (mm)
let width = 6.0; // [4.0, 12.0] Clip width (mm)
let gap = 1.5; // [0.5, 3.0] Jaw gap (mm)
let upper = box(length, width, arm_t).translate([0, 0, gap / 2.0]);
let lower = box(length, width, arm_t).translate([0, 0, -gap / 2.0 - arm_t]);
let hinge = cylinder([0, 0, 0], "Y", gap / 2.0 + arm_t, width) - cylinder([0, -1, 0], "Y", gap / 2.0, width + 2.0) - box_from_corners([0, -1, -10], [10, width + 1, 10]);
let hook = box_from_corners([length - 0.01, 0, -gap / 2.0 - arm_t], [length + arm_t, width, gap / 2.0 + arm_t + 1.5]) + box_from_corners([length - 3.0, 0, gap / 2.0 + arm_t], [length + arm_t, width, gap / 2.0 + arm_t + 1.5]);
fuse_all([upper, lower, hinge, hook])
