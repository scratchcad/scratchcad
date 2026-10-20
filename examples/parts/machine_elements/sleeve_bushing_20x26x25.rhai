// Plain bronze sleeve bushing ISO 4379 C 20 x 26 x 25: 20 mm bore, 26 mm OD, 25 mm long, 0.5 mm x 45 deg chamfers, 3 mm lube hole with an internal 2 mm oil groove
let bore = 20.0; // [6.0, 60.0] Bore diameter (mm)
let outer_diameter = 26.0; // [9.0, 75.0] Outer diameter (mm)
let length = 25.0; // [6.0, 80.0] Length (mm)
let ri = bore / 2.0;
let ro = max(outer_diameter / 2.0, ri + 1.5);
let bush = cylinder(ro, length) - cylinder([0, 0, -1], "Z", ri, length + 2.0);
bush = bush.chamfer(min(0.5, (ro - ri) * 0.3), "%CIRCLE");
let groove = torus(ri, 1.0).translate([0, 0, length / 2.0]);
let hole = cylinder([0, 0, length / 2.0], "X", 1.5, ro + 1.0);
bush - fuse_all([groove, hole])
