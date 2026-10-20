// Hasp and staple: 30 x 80 x 2 mm hinged hasp with a 8 x 25 mm slot and three holes; 30 x 40 mm staple plate with a 5 mm loop
let len = 80.0; // [60.0, 120.0] Hasp length (mm)
let hasp = box_from_corners([-15.0, 0, 0], [15.0, len, 2.0]).fillet(4.0, "|Z") - box_centered(8.0, 25.0, 6.0).translate([0, len - 20.0, 1.0]);
hasp = hasp + cylinder([-15.0, 0, 3.0], "X", 3.0, 30.0) - cylinder([-16.0, 0, 3.0], "X", 1.2, 32.0);
for p in [[-8.0, 12.0], [8.0, 12.0], [0.0, 30.0]] { hasp -= cylinder([p[0], p[1], -1], "Z", 2.0, 4.0); }
let staple = box_from_corners([-15.0, len - 40.0, -6.0], [15.0, len, -4.0]);
let loop_arch = torus(6.0, 2.5).rotate_y(90.0).translate([0, len - 20.0, -4.0]) & box_from_corners([-5, len - 30.0, -4.0], [5, len - 10.0, 6.0]);
for y in [len - 34.0, len - 6.0] { staple -= cylinder([0, y, -7], "Z", 2.0, 4.0); }
compound([hasp, staple + loop_arch])
