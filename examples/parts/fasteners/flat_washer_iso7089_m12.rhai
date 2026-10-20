// Plain washer ISO 7089 size 12: 13 mm hole, 24 mm outside diameter, 2.5 mm thick, punched edge with 0.3 mm break on one side
let hole = 13.0; // [1.7, 37.0] Hole diameter (mm)
let outer_diameter = 24.0; // [4.0, 66.0] Outer diameter (mm)
let thickness = 2.5; // [0.3, 5.0] Thickness (mm)
let ri = hole / 2.0;
let ro = max(outer_diameter / 2.0, ri + 0.8);
let washer = cylinder(ro, thickness) - cylinder([0, 0, -1], "Z", ri, thickness + 2.0);
washer.chamfer(min(0.3, thickness * 0.2), "%CIRCLE and >Z")
