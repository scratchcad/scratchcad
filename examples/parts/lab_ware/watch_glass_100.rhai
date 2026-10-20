// 100 mm watch glass: spherical cap 12 mm deep, 1.5 mm thick, fire-polished rounded rim
let d = 100.0; // [50.0, 200.0] Diameter (mm)
let depth = 12.0; // [6.0, 25.0] Depth (mm)
let R = (d * d / 4.0 + depth * depth) / (2.0 * depth);
let cap = (sphere([0, 0, R], R) - sphere([0, 0, R], R - 1.5)) & box_centered(d + 10.0, d + 10.0, depth).translate([0, 0, depth / 2.0]);
cap
