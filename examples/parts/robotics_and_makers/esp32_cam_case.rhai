// Snap case for an ESP32-CAM board (27 x 40.5 x 4.5 mm PCB): 1.6 mm walls, 12 mm tall, 8.5 mm lens hole and LED window in the front, header/USB slot in the end wall, 10 mm tripod boss with a 5 mm hole beside the lens
let pcb_w = 27.0; // [25.0, 30.0] Board width (mm)
let pcb_l = 40.5; // [38.0, 45.0] Board length (mm)
let depth = 12.0; // [9.0, 20.0] Inside depth (mm)
let lens_d = 8.5; // [6.0, 14.0] Lens hole diameter (mm)
const wall = 1.6;
let w = pcb_w + 0.6 + 2.0 * wall;
let l = pcb_l + 0.6 + 2.0 * wall;
let c = box_from_corners([-w / 2.0, -l / 2.0, 0], [w / 2.0, l / 2.0, depth + wall]).fillet(3.0, "|Z").fillet(1.0, "<Z");
c -= box_from_corners([-w / 2.0 + wall, -l / 2.0 + wall, wall], [w / 2.0 - wall, l / 2.0 - wall, depth + wall + 1.0]).fillet(1.5, "|Z");
c -= cylinder([0, l / 2.0 - wall - 0.3 - 11.5, -1], "Z", lens_d / 2.0, wall + 2.0);
c -= box_centered(4.0, 3.0, 4.0).translate([0, l / 2.0 - 5.0, 0]);
c -= box_centered(w - 2.0 * wall - 4.0, 5.0, depth).translate([0, -l / 2.0, depth / 2.0 + wall + 3.0]);
let ledge = [];
for s in [-1.0, 1.0] { ledge.push(box_from_corners([s * (w / 2.0 - wall) - s * 1.0, -l / 2.0 + wall + 5.0, depth + wall - 6.5], [s * (w / 2.0 - wall) + s * 0.01, l / 2.0 - wall - 5.0, depth + wall - 5.5])); }
c = fuse_all([c] + ledge);
let by = -l / 2.0 + wall + 0.3 + 6.0;
c += cylinder([0, by, wall - 0.01], "Z", 5.0, 5.0);
c - cylinder([0, by, -1], "Z", 2.5, wall + 7.0)
