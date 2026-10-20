// Seam ripper handle: 80 mm, 10 mm grip with flats, 1.6 mm blade socket, cap groove
let length = 80.0; // [60.0, 110.0] Handle length (mm)
let grip_d = 10.0; // [7.0, 14.0] Grip diameter (mm)
let socket_d = 1.6; // [1.0, 3.0] Blade shank diameter (mm)
let profile = sketch("XZ").move_to(0, 0).hline_to(grip_d / 2.0 - 1.0).line_to(grip_d / 2.0, 2.0).vline_to(length - 18.0).line_to(3.5, length - 4.0).vline_to(length).hline_to(0).close();
let body = profile.face().revolve("Z", 360);
let flats = box_from_corners([-10, grip_d / 2.0 - 0.8, 8.0], [10, 10, length - 25.0]) + box_from_corners([-10, -10, 8.0], [10, -grip_d / 2.0 + 0.8, length - 25.0]);
let groove = cylinder([0, 0, length - 14.0], "Z", grip_d, 1.0) - cylinder([0, 0, length - 15.0], "Z", grip_d / 2.0 - 0.5, 3.0);
body - flats - groove - cylinder([0, 0, length - 15.0], "Z", socket_d / 2.0, 16.0)
