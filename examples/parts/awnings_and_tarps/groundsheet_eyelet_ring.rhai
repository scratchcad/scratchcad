// Plastic groundsheet eyelet: 12 mm hole, 26 mm washer flange 1.5 mm, 6 mm tall barrel with a 0.8 mm snap bead (one half)
let hole = 12.0; // [8.0, 20.0] Hole diameter (mm)
let flange = 26.0; // [18.0, 40.0] Flange diameter (mm)
let barrel = 6.0; // [3.0, 10.0] Barrel height (mm)
let e = cylinder(flange / 2.0, 1.5) + cylinder([0, 0, 1.49], "Z", hole / 2.0 + 1.5, barrel) + cylinder([0, 0, barrel - 0.5], "Z", hole / 2.0 + 2.3, 0.8);
e - cylinder([0, 0, -1], "Z", hole / 2.0, barrel + 4.0)
