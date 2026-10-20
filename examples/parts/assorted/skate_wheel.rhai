// 52 mm skateboard wheel with 608 bearing seats
let diameter = 52.0; // [48.0, 60.0] Wheel diameter (mm)
let width = 32.0; // [28.0, 40.0] Wheel width (mm)
let edge_r = 5.0; // [2.0, 10.0] Running edge radius (mm)
let seat_d = 22.0; // [22.0, 22.2] Bearing seat diameter (mm)
let seat_depth = 7.0; // [6.0, 8.0] Bearing seat depth (mm)
let spacer_w = 10.0; // [6.0, 14.0] Spacer step width (mm)
let wheel = cylinder(diameter / 2.0, width).fillet(edge_r, "%CIRCLE");
wheel -= cylinder([0, 0, -1], "Z", seat_d / 2.0, seat_depth + 1.0);
wheel -= cylinder([0, 0, width - seat_depth], "Z", seat_d / 2.0, seat_depth + 1.0);
wheel -= cylinder([0, 0, -1], "Z", 5.0, width + 2.0); // 10 mm bore through the spacer step
wheel
