// Clip-on hotend fan mount for a 22.3 mm heatsink: 270 degree ring 2 mm thick, 10 mm tall, with a 30 mm fan face
let sink_d = 22.3; // [16.0, 30.0] Heatsink diameter (mm)
let height = 10.0; // [6.0, 20.0] Ring height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let fan = 30.0; // [25.0, 40.0] Fan size (mm)
let r = sink_d / 2.0;
let ring = cylinder(r + wall, height) - cylinder([0, 0, -1], "Z", r, height + 2.0) - box_from_corners([-r * 0.7, -r - 5, -1], [r * 0.7, 0, height + 1]);
let face = box_centered(fan, wall, fan).translate([0, r + wall + 1.0, height / 2.0]) - cylinder([0, r, height / 2.0], "Y", fan * 0.45, 10.0);
for sx in [-1, 1] { for sz in [-1, 1] { face -= cylinder([sx * 12.0, r - 2, height / 2.0 + sz * 12.0], "Y", 1.4, 10.0); } }
ring + face + box_centered(8.0, 3.0, height).translate([0, r + wall, height / 2.0])
