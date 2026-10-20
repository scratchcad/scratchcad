// Microscope stage clip: 40 mm spring arm 8 mm wide 0.8 mm, 5 mm curled tip, 4 mm pivot post 8 mm
let arm = 40.0; // [30.0, 55.0] Arm length (mm)
let width = 8.0; // [5.0, 12.0] Arm width (mm)
let t = 0.8; // [0.5, 1.2] Arm thickness (mm)
let post = cylinder([0, 0, -8.0], "Z", 2.0, 8.0 + t);
let a = box_from_corners([-4.0, -width / 2.0, 0], [arm, width / 2.0, t]);
let aa = a.fillet(width / 2.0 - 0.5, a.edges("|Z and <X"));
let tip = (cylinder([arm, -width / 2.0, 2.5 + t], "Y", 2.5 + t, width) - cylinder([arm, -width / 2.0 - 1.0, 2.5 + t], "Y", 2.5, width + 2.0)) & box_from_corners([arm, -width, -1], [arm + 5.0, width, 2.5 + t]);
aa + post + tip
