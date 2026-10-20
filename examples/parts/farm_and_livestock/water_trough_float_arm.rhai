// Trough float valve arm: 250 mm lever, 8 mm pivot fork, M10 boss for a 110 mm float, 6 mm plunger slot
let length = 250.0; // [150.0, 350.0] Lever length (mm)
let width = 12.0; // [8.0, 20.0] Width (mm)
let t = 8.0; // [5.0, 12.0] Thickness (mm)
let arm = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let fork = cylinder([0, 0, 0], "Z", 10.0, t) - cylinder([0, 0, -1], "Z", 4.0, t + 2.0);
let slot = box_from_corners([18.0, -3.0, -1], [30.0, 3.0, t + 1.0]);
let boss = cylinder([length, 0, 0], "Z", 10.0, t + 8.0) - cylinder([length, 0, -1], "Z", 4.25, t + 10.0);
arm + fork + boss - slot
