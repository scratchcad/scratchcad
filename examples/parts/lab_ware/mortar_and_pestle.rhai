// Porcelain mortar and pestle: 110 mm mortar 65 mm tall with a 40 mm deep bowl and pouring lip, 140 mm pestle with a 35 mm head
let d = 110.0; // [70.0, 160.0] Mortar diameter (mm)
let r = d / 2.0;
let mortar = sketch("XZ").move_to(0, 0).line_to(r * 0.6, 0).arc_to(r * 0.95, 25.0, r, 60.0).line_to(r, 65.0).line_to(r - 6.0, 65.0).arc_to(r * 0.55, 32.0, 0, 25.0).close().to_face().revolve("Z", 360);
let pestle = sketch("XZ").move_to(0, 0).arc_to(14.0, 4.0, 17.5, 20.0).arc_to(12.0, 35.0, 9.0, 60.0).line_to(10.0, 125.0).arc_to(8.0, 136.0, 0, 140.0).close().to_face().revolve("Z", 360);
compound([mortar, pestle.translate([d + 20.0, 0, 0])])
