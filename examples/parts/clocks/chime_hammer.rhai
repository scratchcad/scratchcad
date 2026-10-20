// Chime hammer: 40 mm arm 3 x 4 mm, 10 mm diameter 8 mm head with a 6 mm leather-pad recess, 2 mm pivot
let arm = 40.0; // [25.0, 60.0] Arm length (mm)
let head_d = 10.0; // [6.0, 15.0] Head diameter (mm)
let a = box_from_corners([0, -1.5, -2.0], [arm, 1.5, 2.0]) + cylinder([0, -1.5, 0], "Y", 3.0, 3.0);
let head = cylinder([arm, -4.0, 0], "Y", head_d / 2.0, 8.0);
a + head - cylinder([arm, 3.0, 0], "Y", 3.0, 2.0) - cylinder([0, -3.0, 0], "Y", 1.0, 6.0)
