// Cubicle door coat hook with door-stop bumper: 50 mm round wall rose 6 mm thick with a 1 mm chamfer, a 12 mm arm out 45 mm that turns up into a 25 mm tall hook tip, and a 20 mm bumper boss 12 mm proud under the arm to stop the door, with a 5 mm countersunk screw hole through the bumper boss
let arm_len = 45.0; // [30.0, 70.0] Arm length (mm)
let hook_h = 25.0; // [15.0, 40.0] Hook tip height (mm)
let bumper_d = 20.0; // [14.0, 30.0] Bumper diameter (mm)
let rose_d = 50.0; // [40.0, 70.0] Rose diameter (mm)
const rose_t = 6.0;
const arm = 12.0;
let rr = rose_d / 2.0;
let rose = cylinder([0, 0, 0], "Y", rr, rose_t);
let rose = rose.chamfer(1.0, rose.edges(">Y"));
let zc = rr * 0.3;
let arm_b = box_from_corners([-arm / 2.0, rose_t - 0.5, zc - arm / 2.0], [arm / 2.0, rose_t + arm_len, zc + arm / 2.0]);
let tip = box_from_corners([-arm / 2.0, rose_t + arm_len - arm, zc - arm / 2.0], [arm / 2.0, rose_t + arm_len, zc + hook_h]);
let hook = (arm_b + tip).fillet(3.0, (arm_b + tip).edges("|X and >Y"));
let br = min(bumper_d / 2.0, rr - 3.0);
let bz = -rr + br + 2.0;
let bumper = cylinder([0, rose_t - 0.5, bz], "Y", br, 12.5);
let body = fuse_all([rose, hook, bumper]);
let cuts = [cylinder([0, -1.0, bz], "Y", 2.5, rose_t + 20.0), cone(2.5, 5.0, 2.5).rotate_x(-90.0).translate([0, rose_t + 12.0 - 2.49, bz])];
(body - fuse_all(cuts)).mirror("XZ")
