// Clay cut-off wire toggle: 50 mm long 14 mm diameter grip with a 1 mm wire hole and crimp pocket 3 mm
let length = 50.0; // [35.0, 70.0] Toggle length (mm)
let d = 14.0; // [10.0, 20.0] Diameter (mm)
let g = cylinder([-length / 2.0, 0, 0], "X", d / 2.0, length);
let gg = g.fillet(d / 2.0 - 1.0, g.edges("%CIRCLE"));
gg - cylinder([0, 0, -d], "Z", 0.6, d * 2.0) - cylinder([0, 0, d / 2.0 - 4.0], "Z", 1.5, 5.0)
