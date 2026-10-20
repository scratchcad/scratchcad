// Pyramid fence post cap for a 4x4 post (89 mm actual): 96 mm square skirt 25 mm deep, 3 mm wall, 30 mm pyramid, two nail holes
let post = 89.0; // [60.0, 150.0] Post size (mm)
let skirt_depth = 25.0; // [10.0, 50.0] Skirt depth (mm)
let wall = 3.0; // [2.0, 6.0] Wall thickness (mm)
let peak = 30.0; // [10.0, 60.0] Pyramid height (mm)
let inner = post + 1.0;
let outer = inner + 2.0 * wall;
let skirt = box_centered(outer, outer, skirt_depth).translate([0, 0, skirt_depth / 2.0]);
let brim = box_centered(outer + 6.0, outer + 6.0, 4.0).translate([0, 0, skirt_depth + 2.0]).chamfer(1.0, "|Z");
let pyramid = loft([rect(plane([0, 0, skirt_depth + 3.9], "Z"), outer + 6.0, outer + 6.0), rect(plane([0, 0, skirt_depth + 4.0 + peak], "Z"), 4.0, 4.0)], true);
let cap = fuse_all([skirt, brim, pyramid]);
cap -= box_centered(inner, inner, 2.0 * skirt_depth).translate([0, 0, -1.0]);
cap -= cylinder([-1.0 - outer / 2.0, 0, skirt_depth * 0.5], "X", 1.6, wall + 2.0);
cap -= cylinder([outer / 2.0 - wall - 1.0, 0, skirt_depth * 0.5], "X", 1.6, wall + 2.0);
cap
