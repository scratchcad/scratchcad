// Bolt-down fence post bracket for 70 mm square posts: 150 mm square 6 mm base plate with four 12 mm holes, 75 mm open U socket 150 mm tall
let post = 70.0; // [50.0, 100.0] Post size (mm)
const t = 3.0;
let base = box_centered(150.0, 150.0, 6.0).translate([0, 0, 3.0]);
for x in [-55.0, 55.0] { for y in [-55.0, 55.0] { base -= cylinder([x, y, -1], "Z", 6.0, 8.0); } }
let socket = box_centered(post + 2.0 * t, post + 2.0 * t, 150.0).translate([0, 0, 75.0 + 5.9]) - box_centered(post, post, 160.0).translate([0, 0, 85.0]) - box_centered(post, post + 10.0, 160.0).translate([0, post / 2.0 + t, 85.0]);
let b = base + socket;
for z in [50.0, 120.0] { b -= cylinder([-post, 0, z], "X", 5.5, 2.0 * post); }
b
