// Webcam privacy cover: 25 x 10 x 1.2 mm frame with a 6 mm lens window and sliding shutter channel
let length = 25.0; // [18.0, 40.0] Length (mm)
let width = 10.0; // [7.0, 15.0] Width (mm)
let t = 1.2; // [0.8, 2.0] Thickness (mm)
let lens = 6.0; // [3.0, 10.0] Window diameter (mm)
let frame = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let f = frame.fillet(width / 2.0 - 0.01, frame.edges("|Z"));
let rails = box_from_corners([-length / 2.0 + 3.0, -width / 2.0 + 0.5, t - 0.01], [length / 2.0 - 3.0, -width / 2.0 + 1.5, t + 0.8]) + box_from_corners([-length / 2.0 + 3.0, width / 2.0 - 1.5, t - 0.01], [length / 2.0 - 3.0, width / 2.0 - 0.5, t + 0.8]);
f + rails - cylinder([-length / 4.0, 0, -1], "Z", lens / 2.0, t + 3.0)
