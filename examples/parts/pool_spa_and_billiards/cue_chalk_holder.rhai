// Magnetic cue chalk holder: 25 mm cube pocket for 22 mm chalk, 32 x 32 x 25 mm body, 12 x 3 mm magnet pocket, belt clip
let chalk = 22.5; // [20.0, 25.0] Chalk cube size (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let s = chalk + 2.0 * wall;
let body = box_centered(s, s, chalk * 0.8 + wall).translate([0, 0, (chalk * 0.8 + wall) / 2.0]);
let b = body.fillet(3.0, body.edges("|Z"));
let clip = box_from_corners([-6.0, s / 2.0 - 0.01, 2.0], [6.0, s / 2.0 + 2.0, chalk * 0.8]) + box_from_corners([-6.0, s / 2.0 + 0.5, 2.0], [6.0, s / 2.0 + 4.0, 4.0]);
b - box_centered(chalk, chalk, chalk).translate([0, 0, chalk / 2.0 + wall]) - cylinder([0, 0, -1], "Z", 6.0, 3.0) + clip
