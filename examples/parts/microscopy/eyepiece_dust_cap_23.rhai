// Microscope eyetube dust cap: 23.2 mm bore 10 mm deep, 26 mm OD, 1.5 mm top, 8 grip ribs
let bore = 23.2; // [23.0, 30.5] Eyetube OD (mm)
let depth = 10.0; // [6.0, 15.0] Depth (mm)
let wall = 1.4; // [1.0, 2.0] Wall (mm)
let c = cylinder(bore / 2.0 + wall, depth + 1.5) - cylinder([0, 0, -1], "Z", bore / 2.0, depth + 1.0);
let ribs = [];
for k in 0..8 { ribs.push(box_centered(1.0, 1.0, depth - 2.0).translate([bore / 2.0 + wall, 0, depth / 2.0]).rotate_z(k.to_float() * 45.0)); }
c + compound(ribs)
