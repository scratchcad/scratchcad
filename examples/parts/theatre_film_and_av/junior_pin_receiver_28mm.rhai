// Junior pin receiver: 1 1/8 in (28.6 mm) socket 29 mm bore 75 mm deep in a 38 mm tube, 3 mm drain at the bottom, M10 T-handle lock boss 20 mm, 60 x 60 x 8 mm mounting plate with four 8.5 mm holes
let bore = 29.0; // [28.8, 30.0] Socket bore (mm)
let depth = 75.0; // [50.0, 100.0] Socket depth (mm)
let tube = 38.0; // [36.0, 45.0] Tube diameter (mm)
let plate = 60.0; // [50.0, 90.0] Plate size (mm)
let base = box_centered(plate, plate, 8.0).translate([0, 0, 4.0]);
let b = base.fillet(5.0, base.edges("|Z"));
let t = cylinder([0, 0, 7.99], "Z", tube / 2.0, depth + 5.0);
let boss = cylinder([tube / 2.0 - 3.0, 0, depth * 0.7], "X", 10.0, 12.0);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (plate / 2.0 - 8.0), sy * (plate / 2.0 - 8.0), -1.0], "Z", 4.25, 10.0)); } }
(b + t + boss) - cylinder([0, 0, 13.0], "Z", bore / 2.0, depth + 1.0) - cylinder([0, 0, -1.0], "Z", 1.5, 20.0) - cylinder([0, 0, depth * 0.7], "X", 4.25, tube) - compound(holes)
