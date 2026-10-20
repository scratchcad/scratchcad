// DIN 9021 M5 large (fender) washer: 5.3 mm ID, 15 mm OD, 1.2 mm thick
let inner_d = 5.3; // [3.2, 12.7] Inner diameter (mm)
let outer_d = 15.0; // [9.0, 72.0] Outer diameter (mm)
let thickness = 1.2; // [0.8, 6.0] Thickness (mm)
cylinder(outer_d / 2.0, thickness) - cylinder([0, 0, -1], "Z", inner_d / 2.0, thickness + 2.0)
