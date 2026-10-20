// Pressure stair gate wall cup: 38 mm cup 8 mm deep for a 32 mm spindle pad, 50 mm disc 3 mm, adhesive recess
let disc = 50.0; // [40.0, 70.0] Disc diameter (mm)
let pad = 32.0; // [25.0, 45.0] Spindle pad diameter (mm)
let depth = 8.0; // [5.0, 12.0] Cup depth (mm)
let c = cylinder(disc / 2.0, 3.0) + cylinder([0, 0, 2.99], "Z", pad / 2.0 + 3.0, depth);
let cc = c.fillet(1.0, c.edges(">Z"));
cc - cylinder([0, 0, 3.0], "Z", pad / 2.0 + 0.5, depth + 1.0) - cylinder([0, 0, -1], "Z", disc / 2.0 - 4.0, 1.5)
