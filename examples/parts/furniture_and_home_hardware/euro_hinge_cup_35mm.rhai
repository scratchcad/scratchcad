// Concealed 35 mm Euro cabinet hinge: 11.5 mm deep cup, 1.5 mm flange with two 4.5 mm screw holes 45 mm apart offset 9.5 mm, U-channel arm
let cup_d = 35.0; // [26.0, 40.0] Cup diameter (mm)
let depth = 11.5; // [8.0, 13.0] Cup depth (mm)
let r = cup_d / 2.0;
let cup = cylinder([0, 0, -depth], "Z", r, depth + 1.5) - cylinder([0, 0, -depth + 1.0], "Z", r - 1.0, depth + 1.0);
let flange = box_from_corners([-28.0, -16.0, 0], [28.0, 4.0, 1.5]).fillet(4.0, "|Z") - cylinder([0, 0, -1], "Z", r - 1.0, 4.0);
for x in [-22.5, 22.5] { flange -= cylinder([x, -9.5, -1], "Z", 2.25, 4.0) + cone(2.25, 4.0, 1.5).translate([x, -9.5, 0.01]); }
let arm = box_from_corners([-8.0, -70.0, 1.5], [8.0, -12.0, 12.0]) - box_from_corners([-6.5, -71.0, 1.4], [6.5, -11.0, 10.5]);
let knuckle = cylinder([-8.0, -12.0, 8.0], "X", 4.0, 16.0);
fuse_all([cup, flange, arm, knuckle])
