// Grow light rope hanger hook: 4 mm rod J-hook, 20 mm hook width, 25 mm shank, 10 mm flat eye
let rod = 4.0; // [3.0, 6.0] Rod diameter (mm)
let hook_r = 10.0; // [6.0, 16.0] Hook radius (mm)
let shank = 25.0; // [15.0, 40.0] Shank length (mm)
let r = rod / 2.0;
let s = cylinder(r, shank);
let hook = torus(hook_r, r).rotate_x(90.0).translate([-hook_r, 0, 0]) & box_from_corners([-2.0 * hook_r - rod, -rod, -hook_r - rod], [rod, rod, 0]);
let tip = cylinder([-2.0 * hook_r, 0, 0], "Z", r, 6.0) + sphere([-2.0 * hook_r, 0, 6.0], r);
let eye = cylinder([0, -r, shank + 5.0 + r], "Y", 5.0 + rod, rod) - cylinder([0, -rod, shank + 5.0 + r], "Y", 5.0, 2.0 * rod);
s + hook + tip + eye
