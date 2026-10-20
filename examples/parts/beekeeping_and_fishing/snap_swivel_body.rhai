// Barrel swivel body size 7: 13 mm barrel 4.2 mm, two 1 mm wire eye holes, 0.6 mm wall
let length = 13.0; // [8.0, 20.0] Barrel length (mm)
let d = 4.2; // [3.0, 6.0] Barrel diameter (mm)
let b = cylinder(d / 2.0, length) & (sphere([0, 0, length / 2.0], length * 0.48));
b - cylinder([0, 0, 1.0], "Z", d / 2.0 - 0.6, length - 2.0) - cylinder([0, 0, -1], "Z", 0.5, length + 2.0)
