// Engine oil dipstick handle: 36 x 26 mm loop 5 mm thick with a 22 x 12 mm finger hole, 10 mm socket 18 mm long with a 4.5 mm bore for the dipstick tube, O-ring groove
let loop_w = 36.0; // [28.0, 50.0] Loop width (mm)
let loop_h = 26.0; // [20.0, 34.4] Loop height (mm)
let loop_t = 5.0; // [3.0, 8.0] Loop thickness (mm)
let rim = 7.0; // [4.0, 10.0] Rim width (mm)
let socket_d = 10.0; // [8.0, 14.0] Socket diameter (mm)
let socket_length = 18.0; // [10.0, 30.0] Socket length (mm)
let bore_d = 4.5; // [3.0, 7.0] Dipstick bore (mm)
let rr = min(rim, loop_h / 2.0 - 3.0);
let outer = box_centered(loop_w, loop_t, loop_h).translate([0, 0, socket_length + loop_h / 2.0]).fillet(loop_h / 2.0 - 0.5, "|Y");
let hole = box_centered(loop_w - 2.0 * rr, loop_t + 2.0, loop_h - 2.0 * rr).translate([0, 0, socket_length + loop_h / 2.0]).fillet(loop_h / 2.0 - rr - 0.5, "|Y");
let handle = (outer - hole) + cylinder([0, 0, 0], "Z", socket_d / 2.0, socket_length + 2.0);
handle = handle - (cylinder([0, 0, 4.0], "Z", socket_d / 2.0 + 1.0, 2.0) - cylinder([0, 0, 3.0], "Z", socket_d / 2.0 - 1.0, 4.0));
handle - cylinder([0, 0, -1.0], "Z", bore_d / 2.0, socket_length)
