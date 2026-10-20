// DIN 125-A M8 flat washer
let inner_diameter = 8.4; // [3.0, 20.0] Hole diameter (mm)
let outer_diameter = 16.0; // [8.0, 40.0] Outside diameter (mm)
let thickness = 1.6; // [0.5, 5.0] Thickness (mm)
let od = max(outer_diameter, inner_diameter + 2.0);
cylinder(od / 2.0, thickness) - cylinder([0, 0, -1], "Z", inner_diameter / 2.0, thickness + 2.0)
