// Pool ball: 57.15 mm (2 1/4 in) sphere with a 25 mm number circle recessed 0.3 mm on two sides
let d = 57.15; // [50.8, 61.5] Ball diameter (mm)
let circle_d = 25.0; // [15.0, 30.0] Number circle diameter (mm)
let b = sphere(d / 2.0);
b - (cylinder([-d, 0, 0], "X", circle_d / 2.0, d * 2.0) - cylinder([-d / 2.0 + 0.3, 0, 0], "X", circle_d, d - 0.6))
