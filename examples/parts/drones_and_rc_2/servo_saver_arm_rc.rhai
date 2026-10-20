// RC car servo saver horn: 25T spline 5.8 mm, 30 mm arm with 2 ball-link holes 2.5 mm at 14 and 20 mm, 6 mm thick
let arm = 30.0; // [20.0, 40.0] Arm length (mm)
let spline = 5.8; // [4.8, 6.0] Spline bore (mm)
let t = 6.0; // [4.0, 8.0] Thickness (mm)
let a = box_from_corners([0, -4.0, 0], [arm, 4.0, t]) + cylinder(6.0, t);
let tip = cylinder([arm, 0, 0], "Z", 4.0, t);
a + tip - cylinder([0, 0, -1], "Z", spline / 2.0, t + 2.0) - cylinder([14.0, 0, -1], "Z", 1.25, t + 2.0) - cylinder([20.0, 0, -1], "Z", 1.25, t + 2.0) - box_from_corners([-7.0, -0.6, -1], [-1.0, 0.6, t + 1.0])
