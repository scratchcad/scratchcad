// Plain washer ISO 7089 size 8 (normal series, 200 HV): 8.4 mm hole, 16 mm outside diameter, 1.6 mm thick, 0.2 mm edge break
let hole = 8.4; // [1.7, 37.0] Hole diameter (mm)
let outer_diameter = 16.0; // [4.0, 66.0] Outer diameter (mm)
let thickness = 1.6; // [0.3, 5.0] Thickness (mm)
let ri = hole / 2.0;
let ro = max(outer_diameter / 2.0, ri + 0.8);
let washer = cylinder(ro, thickness) - cylinder([0, 0, -1], "Z", ri, thickness + 2.0);
washer.chamfer(min(0.2, thickness * 0.2), "%CIRCLE")
