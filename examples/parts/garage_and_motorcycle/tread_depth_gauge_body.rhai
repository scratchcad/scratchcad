// Tyre tread depth gauge body: 60 x 14 x 9 mm barrel, 25 x 3 mm foot bar, 2.2 mm probe bore, 4 x 30 mm scale window, 1 mm edge rounds
let length = 60.0; // [40.0, 90.0] Body length (mm)
let body_width = 14.0; // [10.0, 20.0] Body width (mm)
let body_depth = 9.0; // [6.0, 14.0] Body depth (mm)
let foot_length = 25.0; // [16.0, 40.0] Foot bar length (mm)
let probe_d = 2.2; // [1.5, 3.0] Probe bore (mm)
let window_length = 30.0; // [10.0, 45.0] Scale window length (mm)
let body = box_centered(body_width, body_depth, length).translate([0, 0, length / 2.0 + 3.0]).fillet(1.0, "|Z");
let foot = box_centered(max(foot_length, body_width + 2.0), body_depth, 3.0).translate([0, 0, 1.5]).fillet(1.0, "|Z");
let gauge = body + foot;
let wl = min(window_length, length - 14.0);
gauge = gauge - box_centered(4.0, body_depth, wl).translate([0, -body_depth / 2.0, 3.0 + 8.0 + wl / 2.0]).fillet(1.9, "|Y");
gauge = gauge - cylinder([0, 0, -1.0], "Z", probe_d / 2.0, length + 5.0);
gauge - box_centered(body_width - 3.0, body_depth - 3.0, 12.0).translate([0, 0, length + 3.0 - 5.0])
