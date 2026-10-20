// Scratch awl: 30 mm bulb handle 95 mm long, 12 mm ferrule, 4 mm steel shank 70 mm to a fine point
let shank = 70.0; // [40.0, 120.0] Shank length (mm)
let handle = sketch("XZ").move_to(0, 0).line_to(6.0, 0).line_to(6.0, 12.0).arc_to(15.0, 55.0, 9.0, 85.0).arc_to(6.0, 93.0, 0, 95.0).close().to_face().revolve("Z", 360);
let steel = cylinder([0, 0, -shank + 15.0], "Z", 2.0, shank) + cone(0.05, 2.0, 15.0).translate([0, 0, -shank]);
handle + steel
