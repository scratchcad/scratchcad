// Wargaming miniature base: 32 mm round, 4 mm tall with a 1 mm top bevel, 10 x 3 mm magnet pocket underneath
let d = 32.0; // [20.0, 60.0] Base diameter (mm)
let height = 4.0; // [3.0, 6.0] Height (mm)
let magnet = 10.0; // [5.0, 15.0] Magnet diameter (mm)
let b = cone(d / 2.0, d / 2.0 - 1.0, height);
b - cylinder([0, 0, -1], "Z", magnet / 2.0 + 0.1, 4.0) - (cylinder([0, 0, -1], "Z", d / 2.0 - 1.2, height - 1.0 + 1.0) - cylinder([0, 0, -2], "Z", magnet / 2.0 + 1.2, height + 2.0))
