// Cabinet child safety latch: 70 mm flexible latch arm 10 mm wide, 2 mm thick with a 6 mm catch hook, on a 25 x 15 mm screw-on base 4 mm with two 3.5 mm holes
let arm = 70.0; // [50.0, 100.0] Latch arm length (mm)
let hook = 6.0; // [4.0, 10.0] Catch hook height (mm)
const t = 2.0;
let base = box_from_corners([0, -7.5, 0], [25.0, 7.5, 4.0]);
let a = box_from_corners([24.99, -5.0, 2.0], [25.0 + arm, 5.0, 2.0 + t]);
let h = face(polygon([[25.0 + arm - 8.0, -5.0, 2.0 + t - 0.01], [25.0 + arm, -5.0, 2.0 + t - 0.01], [25.0 + arm, -5.0, 2.0 + t + hook]])).extrude([0, 10.0, 0]);
let tab = box_from_corners([25.0 + arm - 0.01, -5.0, 2.0], [25.0 + arm + 10.0, 5.0, 2.0 + t]);
base + a + h + tab - cylinder([7.0, 0, -1.0], "Z", 1.75, 6.0) - cylinder([18.0, 0, -1.0], "Z", 1.75, 6.0)
