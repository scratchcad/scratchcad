// Wooden train magnetic coupler: 6 x 3 mm magnet cup on a 20 mm arm, 4 mm hinge pin hole, 8 mm wide
let arm = 20.0; // [12.0, 30.0] Arm length (mm)
let magnet = 6.0; // [4.0, 10.0] Magnet diameter (mm)
let width = 8.0; // [6.0, 12.0] Arm width (mm)
let a = box_from_corners([0, -width / 2.0, 0], [arm, width / 2.0, 4.0]) + cylinder([0, 0, 0], "Z", width / 2.0, 4.0);
let head = cylinder([arm, 0, 0], "Z", magnet / 2.0 + 1.5, 4.0);
let h = cylinder([arm + magnet / 2.0 + 1.5 - 0.01, 0, 2.0], "X", magnet / 2.0 + 1.0, 4.0) - cylinder([arm + magnet / 2.0 + 2.5, 0, 2.0], "X", magnet / 2.0 + 0.1, 4.0);
a + head + h - cylinder([0, 0, -1], "Z", 2.0, 6.0)
