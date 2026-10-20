// 4 in C-clamp: 12 mm cast frame 110 x 160 mm with rounded corners, 100 mm opening, anvil pad; separate 12 mm screw with swivel pad and T-bar
let opening = 100.0; // [50.0, 200.0] Jaw opening (mm)
let h = opening + 60.0;
let frame = box_centered(110.0, 12.0, h).fillet(20.0, "|Y") - box_centered(70.0, 14.0, opening + 20.0).fillet(10.0, "|Y");
frame -= box_from_corners([10.0, -10.0, -opening / 2.0 - 10.0], [60.0, 10.0, opening / 2.0 + 10.0]);
frame += cylinder([30.0, 0, -opening / 2.0 - 10.0], "Z", 12.0, 4.0);
frame += cylinder([30.0, 0, opening / 2.0 + 10.0], "Z", 11.0, 20.0);
frame -= cylinder([30.0, 0, opening / 2.0], "Z", 6.3, 40.0);
let screw = fuse_all([cylinder([30.0, 0, -opening / 2.0 + 20.0], "Z", 6.0, opening + 35.0), cylinder([30.0, 0, -opening / 2.0 + 16.0], "Z", 12.0, 4.0), cylinder([10.0, 0, opening / 2.0 + 52.0], "X", 3.0, 40.0)]);
compound([frame, screw])
