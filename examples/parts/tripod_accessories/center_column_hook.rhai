// Tripod centre column weight hook: 20 mm M6 stud, 30 mm hook of 6 mm rod with a safety lip, 12 mm collar
let rod = 6.0; // [4.0, 8.0] Rod diameter (mm)
let hook_r = 15.0; // [10.0, 25.0] Hook radius (mm)
let r = rod / 2.0;
let stud = cylinder([0, 0, 0], "Z", 3.0, 20.0);
let collar = cylinder([0, 0, -6.0], "Z", 6.0, 6.01);
let shank = cylinder([0, 0, -6.0 - 20.0], "Z", r, 20.01);
let hook = (cylinder([-hook_r, -r, -26.0], "Y", hook_r + r, rod) - cylinder([-hook_r, -r - 1.0, -26.0], "Y", hook_r - r, rod + 2.0)) & box_from_corners([-2.0 * hook_r - rod, -rod, -26.0 - hook_r - rod], [rod, rod, -26.0]);
let lip = cylinder([-2.0 * hook_r, 0, -26.0], "Z", r, 6.0);
stud + collar + shank + hook + lip
