// Lid thermometer bezel: 55 mm dial, 60 mm bezel 10 mm deep, 1/2 in (12.7 mm) stem nut boss, glass rebate 1.5 mm
let dial = 55.0; // [40.0, 80.0] Dial diameter (mm)
let depth = 10.0; // [6.0, 15.0] Bezel depth (mm)
let stem = 12.7; // [6.0, 16.0] Stem boss diameter (mm)
let outer = cylinder(dial / 2.0 + 3.0, depth);
let o = outer.fillet(2.0, outer.edges(">Z"));
let cup = o - cylinder([0, 0, 2.0], "Z", dial / 2.0, depth) - cylinder([0, 0, depth - 1.5], "Z", dial / 2.0 + 1.0, 2.0);
cup + cylinder([0, 0, -12.0], "Z", stem / 2.0 + 2.0, 12.01) - cylinder([0, 0, -13.0], "Z", 2.5, 16.0)
