// Hay bale hook: 10 mm rod hooked 150 mm, T-handle 120 mm x 28 mm grip
let rod = 10.0; // [6.0, 14.0] Rod diameter (mm)
let hook_r = 45.0; // [25.0, 70.0] Hook radius (mm)
let shank = 120.0; // [60.0, 180.0] Shank length (mm)
let grip_l = 120.0; // [80.0, 150.0] Grip length (mm)
let r = rod / 2.0;
let s = cylinder([0, 0, 0], "Z", r, shank);
let hook = torus(hook_r, r).rotate_x(90.0).translate([hook_r, 0, 0]) & box_from_corners([-rod, -rod, -hook_r - rod], [2.0 * hook_r + rod, rod, 0]);
let point = cone(r, 0.5, 25.0).translate([2.0 * hook_r, 0, -0.01]);
let grip = cylinder([-grip_l / 2.0, 0, shank + 12.0], "X", 14.0, grip_l);
s + hook + point + grip
