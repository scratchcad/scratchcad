// Turned chair spindle: 450 mm, 22 mm max bead, 15 mm tenons 25 mm long each end, vase and bead profile
let length = 450.0; // [300.0, 700.0] Overall length (mm)
let max_d = 22.0; // [16.0, 35.0] Maximum diameter (mm)
let tenon = 15.0; // [10.0, 20.0] Tenon diameter (mm)
let r = max_d / 2.0;
let tr = tenon / 2.0;
let p = sketch("XZ").move_to(0, 0).hline_to(tr).vline_to(25.0).hline_to(r * 0.8).vline_to(40.0).arc_to(r, 48.0, r * 0.75, 56.0).line_to(r * 0.6, length * 0.35).arc_to(r, length * 0.5, r * 0.6, length * 0.65).line_to(r * 0.75, length - 56.0).arc_to(r, length - 48.0, r * 0.8, length - 40.0).vline_to(length - 25.0).hline_to(tr).vline_to(length).hline_to(0).close();
p.face().revolve("Z", 360)
