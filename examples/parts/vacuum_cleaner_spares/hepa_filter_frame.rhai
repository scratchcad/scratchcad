// Vacuum HEPA filter frame: 120 x 80 mm, 25 mm deep, 2 mm walls, 3 mm seal lip and finger tab 20 mm
let length = 120.0; // [80.0, 180.0] Frame length (mm)
let width = 80.0; // [60.0, 120.0] Frame width (mm)
let depth = 25.0; // [15.0, 40.0] Frame depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let f = box_centered(length, width, depth).translate([0, 0, depth / 2.0]) - box_centered(length - 2.0 * wall, width - 2.0 * wall, depth + 2.0).translate([0, 0, depth / 2.0]);
let lip = box_centered(length + 6.0, width + 6.0, 2.0).translate([0, 0, depth - 1.0]) - box_centered(length - 2.0 * wall, width - 2.0 * wall, 4.0).translate([0, 0, depth - 1.0]);
let tab = box_from_corners([-10.0, width / 2.0 + 2.99, depth - 2.0], [10.0, width / 2.0 + 15.0, depth]);
let ribs = [];
for k in 1..4 { ribs.push(box_centered(1.5, width - 2.0 * wall + 0.02, 6.0).translate([-length / 2.0 + k.to_float() * length / 4.0, 0, 3.0])); }
f + lip + tab + fuse_all(ribs)
