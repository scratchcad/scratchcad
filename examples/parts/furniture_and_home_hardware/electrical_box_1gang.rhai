// Plastic single-gang electrical box: 60 x 95 mm, 63 mm deep, 2.5 mm walls, two device screw bosses 83.3 mm apart, two 22 mm knockouts
let depth = 63.0; // [40.0, 90.0] Depth (mm)
let b = box_centered(60.0, 95.0, depth).translate([0, 0, depth / 2.0]) - box_centered(55.0, 90.0, depth).translate([0, 0, depth / 2.0 + 2.5]);
for y in [-41.65, 41.65] { b += cylinder([0, y, 0], "Z", 4.0, depth - 2.0); }
for y in [-41.65, 41.65] { b -= cylinder([0, y, 10.0], "Z", 1.6, depth); }
for y in [-20.0, 20.0] { b -= cylinder([0, y, -1], "Z", 11.0, 4.0); }
b
