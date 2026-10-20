// Guitar pick holder: holds 10 standard 351 picks, 32 x 30 x 14 mm with a thumb window and strap clip
let width = 32.0; // [28.0, 40.0] Width (mm)
let height = 30.0; // [25.0, 40.0] Height (mm)
let depth = 14.0; // [8.0, 20.0] Depth (mm)
let wall = 1.6; // [1.2, 2.5] Wall (mm)
let shell = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let s = shell.fillet(4.0, shell.edges("|Y"));
let cavity = box_centered(width - 2.0 * wall, depth - 2.0 * wall, height - wall).translate([0, 0, (height - wall) / 2.0 + wall]);
let window = cylinder([0, -depth, height - 4.0], "Y", 9.0, depth);
let clip = box_from_corners([-6.0, depth / 2.0 - 0.01, 6.0], [6.0, depth / 2.0 + 2.0, height - 4.0]) + box_from_corners([-6.0, depth / 2.0 + 0.5, 6.0], [6.0, depth / 2.0 + 4.0, 8.0]);
s - cavity - window + clip
