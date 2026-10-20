// Fence post spike socket head: 75 mm square socket 150 mm deep, 2 mm walls, with two M10 clamp bolt bosses and a 30 mm spike stub below for the 600 mm spike
let post = 75.0; // [70.0, 100.0] Post size (mm)
let depth = 150.0; // [100.0, 200.0] Socket depth (mm)
const wall = 2.0;
let s = box_centered(post + 2.0 * wall, post + 2.0 * wall, depth).translate([0, 0, depth / 2.0]) - box_centered(post + 0.5, post + 0.5, depth).translate([0, 0, depth / 2.0 + wall]);
let bosses = box_from_corners([-12.0, post / 2.0 + wall - 0.01, depth * 0.4], [12.0, post / 2.0 + wall + 10.0, depth * 0.4 + 24.0]) + box_from_corners([post / 2.0 + wall - 0.01, -12.0, depth * 0.7], [post / 2.0 + wall + 10.0, 12.0, depth * 0.7 + 24.0]);
let stub = loft([rect(plane([0, 0, 0.01], [0, 0, -1]), 40.0, 40.0), rect(plane([0, 0, -30.0], [0, 0, -1]), 20.0, 20.0)], true);
s + bosses + stub - cylinder([0, 0, depth * 0.4 + 12.0], "Y", 5.0, post) - cylinder([0, 0, depth * 0.7 + 12.0], "X", 5.0, post)
