// Jet engine inlet lip ring: 100 mm duct bore, 4 mm thick wall 60 mm long, semicircular leading edge
let bore = 100.0; // [50.0, 300.0] Duct bore (mm)
let wall = 4.0; // [2.0, 10.0] Wall thickness (mm)
let len = 60.0; // [20.0, 150.0] Length (mm)
let r = bore / 2.0;
sketch("XZ").move_to(r, 0).line_to(r, len).arc_to(r + wall / 2.0, len + wall / 2.0, r + wall, len).line_to(r + wall, 0).close().to_face().revolve("Z", 360)
