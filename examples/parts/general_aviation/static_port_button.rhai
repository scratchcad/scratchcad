// Static port button: 25 mm flush disc 3 mm, 1.6 mm port hole, 6 mm hose nipple 15 mm behind
let disc = 25.0; // [18.0, 35.0] Disc diameter (mm)
let port = 1.6; // [1.0, 3.0] Port hole (mm)
let nipple = 6.0; // [4.0, 8.0] Nipple diameter (mm)
let d = cylinder(disc / 2.0, 3.0);
let dd = d.chamfer(1.0, d.edges(">Z"));
let n = cylinder([0, 0, -15.0], "Z", nipple / 2.0, 15.01) + cone(nipple / 2.0 + 0.5, nipple / 2.0 - 0.3, 3.0).translate([0, 0, -12.0]);
dd + n - cylinder([0, 0, -16.0], "Z", port / 2.0, 20.0)
