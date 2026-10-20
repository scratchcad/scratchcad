// Ultimate flying disc: 175 mm diameter, 32 mm rim with a rolled lip, gently domed 2 mm flight plate, 1.5 mm wall
let d = 175.0; // [150.0, 275.0] Diameter (mm)
let r = d / 2.0;
let disc = sketch("XZ").move_to(0, 32.0).arc_to(r * 0.6, 31.0, r - 8.0, 29.0).arc_to(r - 1.0, 27.0, r, 20.0).line_to(r - 1.0, 4.0).arc_to(r - 3.0, 0, r - 5.5, 3.0).line_to(r - 5.5, 12.0).line_to(r - 3.0, 22.0).arc_to(r - 6.0, 26.5, r - 10.0, 27.0).arc_to(r * 0.6, 29.0, 0, 30.0).close();
disc.to_face().revolve("Z", 360)
