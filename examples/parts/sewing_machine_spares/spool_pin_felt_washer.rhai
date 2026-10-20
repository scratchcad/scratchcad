// Spool pin felt washer: 18 mm felt disc 2.5 mm thick with a 5 mm hole for the spool pin, 0.4 mm edge chamfers
let outer_d = 18.0; // [12.0, 30.0] Outside diameter (mm)
let hole_d = 5.0; // [3.5, 7.0] Hole diameter (mm)
let thickness = 2.5; // [1.5, 4.0] Thickness (mm)
let disc = cylinder(outer_d / 2.0, thickness);
let disc = disc.chamfer(0.4, disc.edges(">Z or <Z"));
disc - cylinder([0, 0, -1.0], "Z", hole_d / 2.0, thickness + 2.0)
