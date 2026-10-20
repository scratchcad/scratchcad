// Shower curtain rail wall flange for 25 mm tube: 60 mm rose 15 mm deep, tube socket 26 mm, grub screw M5
let tube = 25.0; // [19.0, 32.0] Tube diameter (mm)
let rose = 60.0; // [45.0, 80.0] Rose diameter (mm)
let depth = 30.0; // [20.0, 45.0] Overall depth (mm)
let profile = sketch("XZ").move_to(0, 0).hline_to(rose / 2.0).vline_to(4.0).arc_to(rose / 2.0 - 8.0, 10.0, tube / 2.0 + 3.0, 15.0).vline_to(depth).hline_to(0).close();
let body = profile.face().revolve("Z", 360);
body - cylinder([0, 0, 10.0], "Z", tube / 2.0 + 0.3, depth) - cylinder([0, 0, -1], "Z", 2.5, 12.0) - cylinder([0, -rose, depth - 7.0], "Y", 2.1, rose)
