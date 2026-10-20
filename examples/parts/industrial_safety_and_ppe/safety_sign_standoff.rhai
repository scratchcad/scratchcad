// Safety sign standoff: 25 mm dia x 25 mm aluminium-style standoff with a 3 mm sign shoulder, M6 tapping bore 5 mm 15 mm deep and a 6.5 mm wall fixing hole from the back
let diameter = 25.0; // [16.0, 32.0] Standoff diameter (mm)
let length = 25.0; // [12.0, 50.0] Standoff length (mm)
let tap = 5.0; // [4.2, 6.8] Tapping bore (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(diameter / 2.0).vline_to(length).hline_to(diameter / 2.0 - 3.0).vline_to(length + 3.0).hline_to(0).close();
let body = p.to_face().revolve([0, 0, 0], "Z", 360);
let b = body.chamfer(0.8, body.edges(">Z"));
b - cylinder([0, 0, length + 3.0 - 15.0], "Z", tap / 2.0, 16.0) - cylinder([0, 0, -1.0], "Z", 3.25, (length - 12.0).max(4.0))
