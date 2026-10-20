// Cafeteria tray slide bracket: 60 x 40 mm wall plate 5 mm thick with two 6.5 mm holes, a 50 mm arm and a saddle cradling a 25.4 mm tray slide tube with a 5 mm screw hole up into the tube
let tube_d = 25.4; // [19.0, 32.0] Tube diameter (mm)
let reach = 50.0; // [30.0, 90.0] Arm reach (mm)
let width = 40.0; // [30.0, 60.0] Bracket width (mm)
const t = 5.0;
let rt = tube_d / 2.0 + 0.2;
let plate = box_from_corners([0, -width / 2.0, -30.0], [t, width / 2.0, 30.0]);
let arm = box_from_corners([0, -width / 2.0, -t], [reach + rt + 4.0, width / 2.0, 0]);
let saddle = box_from_corners([reach - rt - 4.0, -width / 2.0, -0.01], [reach + rt + 4.0, width / 2.0, rt]);
let b = plate + arm + saddle;
b = b - cylinder([reach, -width / 2.0 - 1.0, rt + 3.0], "Y", rt, width + 2.0);
b - cylinder([-1.0, 0, -18.0], "X", 3.25, t + 2.0) - cylinder([-1.0, 0, 18.0], "X", 3.25, t + 2.0) - cylinder([reach, 0, -t - 1.0], "Z", 2.5, t + 6.0)
