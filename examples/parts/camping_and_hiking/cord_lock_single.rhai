// Spring cord lock body for 4 mm cord: 20 x 14 x 22 mm, 5 mm cross hole, 9 mm spring bore
let width = 20.0; // [14.0, 28.0] Width (mm)
let depth = 14.0; // [10.0, 20.0] Depth (mm)
let height = 22.0; // [16.0, 30.0] Height (mm)
let cord_hole = 5.0; // [3.0, 8.0] Cord hole (mm)
let body = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let b = body.fillet(4.0, body.edges("|Z"));
let bore = cylinder([0, 0, 2.0], "Z", 4.5, height);
let slot = box_centered(6.5, depth + 2.0, 5.0).translate([0, 0, height * 0.6]);
b - bore - slot - cylinder([0, -depth, height * 0.6], "Y", cord_hole / 2.0, depth * 2.0)
