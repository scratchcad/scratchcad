// Nylon drumstick tip: 10 mm acorn tip 12 mm long, 6 mm socket 8 mm deep for the stick taper
let d = 10.0; // [8.0, 14.0] Tip diameter (mm)
let length = 12.0; // [8.0, 16.0] Tip length (mm)
let socket = 6.0; // [4.0, 8.0] Socket diameter (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(socket / 2.0 + 1.0).line_to(d / 2.0, length * 0.45).line_to(d / 2.0 - 1.0, length * 0.85).line_to(2.0, length).hline_to(0).close();
p.face().revolve("Z", 360) - cylinder([0, 0, -1], "Z", socket / 2.0, 9.0)
