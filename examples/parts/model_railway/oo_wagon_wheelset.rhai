// OO gauge wagon wheelset: 12.6 mm wheels with 1.0 mm flanges, 14.4 mm back-to-back, 2 mm pinpoint axle 26 mm
let wheel_d = 12.6; // [10.0, 16.0] Tread diameter (mm)
let back_to_back = 14.4; // [14.0, 14.8] Back to back (mm)
let axle_l = 26.0; // [24.0, 27.0] Axle length over points (mm)
let tread_w = 2.0; // [1.5, 3.0] Tread width (mm)
let r = wheel_d / 2.0;
let wheel = cone(r, r - 0.15, tread_w) + cylinder([0, 0, -0.6], "Z", r + 0.7, 0.61);
let w1 = wheel.rotate_y(-90.0).translate([-back_to_back / 2.0, 0, 0]);
let w2 = wheel.rotate_y(90.0).translate([back_to_back / 2.0, 0, 0]);
let axle = cylinder([-axle_l / 2.0 + 1.0, 0, 0], "X", 1.0, axle_l - 2.0) + cone(1.0, 0.1, 1.0).rotate_y(90.0).translate([axle_l / 2.0 - 1.01, 0, 0]) + cone(1.0, 0.1, 1.0).rotate_y(-90.0).translate([-axle_l / 2.0 + 1.01, 0, 0]);
w1 + w2 + axle
