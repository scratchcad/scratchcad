// 40 x 40 x 10 mm fan shroud for a hotend: 2 mm walls, 36 mm duct, 32 mm M3 hole pattern, 12 mm deep
let size = 40.0; // [30.0, 60.0] Fan size (mm)
let depth = 12.0; // [6.0, 25.0] Depth (mm)
let wall = 2.0; // [1.2, 3.0] Wall thickness (mm)
let hole_pitch = 32.0; // [24.0, 50.0] Hole spacing (mm)
let shroud = box_centered(size, size, depth).translate([0, 0, depth / 2.0]).fillet(3.0, "|Z") - cylinder([0, 0, -1], "Z", size * 0.45, depth + 2.0);
shroud = shroud - box_centered(size - 2.0 * wall, size - 2.0 * wall, depth - wall).translate([0, 0, depth / 2.0 + wall / 2.0 + 0.01]);
shroud = shroud + (cylinder(size * 0.45 + wall, depth) - cylinder([0, 0, -1], "Z", size * 0.45, depth + 2.0));
for sx in [-1, 1] { for sy in [-1, 1] { shroud -= cylinder([sx * hole_pitch / 2.0, sy * hole_pitch / 2.0, -1], "Z", 1.6, depth + 2.0); } }
shroud
