// Bed slat holder cap: fits a 53 x 8 mm slat, 60 mm long sleeve 1.5 mm, 2 pins 6 mm for 6.5 mm rail holes on 32 mm
let slat_w = 53.0; // [38.0, 70.0] Slat width (mm)
let slat_t = 8.0; // [6.0, 12.0] Slat thickness (mm)
let length = 60.0; // [40.0, 80.0] Cap length (mm)
let wall = 1.5; // [1.2, 2.5] Wall (mm)
let sleeve = box_from_corners([-slat_w / 2.0 - wall, 0, -wall], [slat_w / 2.0 + wall, length, slat_t + wall]) - box_from_corners([-slat_w / 2.0, wall, 0], [slat_w / 2.0, length + 1.0, slat_t]);
let pins = cylinder([-16.0, length / 2.0, -wall - 8.0], "Z", 3.0, 8.01) + cylinder([16.0, length / 2.0, -wall - 8.0], "Z", 3.0, 8.01);
sleeve + pins
