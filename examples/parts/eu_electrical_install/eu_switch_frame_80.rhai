// EU single switch frame: 80 x 80 mm, 10 mm deep, 55 x 55 mm insert window, 1.8 mm wall, 2 clip tabs
let size = 80.0; // [75.0, 90.0] Frame size (mm)
let window = 55.0; // [50.0, 60.0] Insert window (mm)
let depth = 10.0; // [6.0, 14.0] Frame depth (mm)
let wall = 1.8; // [1.2, 2.5] Wall (mm)
let f = box_centered(size, size, depth).translate([0, 0, depth / 2.0]);
let ff = f.fillet(6.0, f.edges("|Z"));
let fff = ff.fillet(2.0, ff.edges(">Z"));
let hollow = box_centered(size - 2.0 * wall, size - 2.0 * wall, depth).translate([0, 0, depth / 2.0 - wall]);
let h = hollow.fillet(4.0, hollow.edges("|Z"));
let tabs = box_centered(10.0, 1.5, 4.0).translate([0, window / 2.0 + 0.75, depth - wall - 2.0]) + box_centered(10.0, 1.5, 4.0).translate([0, -window / 2.0 - 0.75, depth - wall - 2.0]);
fff - h - box_centered(window, window, depth * 3.0) + tabs
