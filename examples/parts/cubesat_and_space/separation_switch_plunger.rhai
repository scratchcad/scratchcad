// CubeSat deployment switch plunger: 4 mm plunger 12 mm travel stem, 6 mm head 2 mm, guide bushing 8 mm x 10 mm (two solids)
let stem = 4.0; // [3.0, 6.0] Plunger diameter (mm)
let travel = 12.0; // [6.0, 20.0] Stem length (mm)
let bush = cylinder([0, 0, 0], "Z", 4.0, 10.0) + cylinder([0, 0, 0], "Z", 5.5, 1.5) - cylinder([0, 0, -1], "Z", stem / 2.0 + 0.1, 12.0);
let plunger = cylinder([0, 0, -3.0], "Z", stem / 2.0, travel + 3.0) + cylinder([0, 0, travel - 0.01], "Z", 3.0, 2.0);
let pt = plunger.chamfer(0.4, plunger.edges("<Z"));
compound([bush, pt.translate([0, 0, 1.0])])
