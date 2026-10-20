// Magnetic parts tray: 150 mm stainless dish 25 mm deep with a rolled 1 mm wall, 50 mm magnet pocket 8 mm deep in a base boss
let d = 150.0; // [100.0, 250.0] Tray diameter (mm)
let r = d / 2.0;
let dish = sketch("XZ").move_to(0, 0).line_to(r - 15.0, 0).arc_to(r - 3.0, 6.0, r, 25.0).line_to(r - 1.0, 25.0).arc_to(r - 4.0, 7.0, r - 15.0, 1.0).line_to(0, 1.0).close().to_face().revolve("Z", 360);
let boss = cylinder([0, 0, -9.0], "Z", 30.0, 9.5) - cylinder([0, 0, -10.0], "Z", 25.0, 9.0);
dish + boss
