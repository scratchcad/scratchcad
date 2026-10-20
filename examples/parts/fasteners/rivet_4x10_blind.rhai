// Blind (pop) rivet 4 mm x 10 mm grip, 8 mm dome head, 2.2 mm mandrel
let body_d = 4.0; // [2.4, 6.4] Body diameter (mm)
let length = 10.0; // [4.0, 25.0] Body length (mm)
let head_d = 8.0; // [5.0, 13.0] Head diameter (mm)
let mandrel_d = 2.2; // [1.3, 3.6] Mandrel diameter (mm)
let head = sketch("XZ").move_to(0, 0).hline_to(head_d / 2.0).arc_to(head_d * 0.3, 1.0, 0, 1.3).close().to_face().revolve("Z", 360);
let body = cylinder([0, 0, -length], "Z", body_d / 2.0, length + 0.1);
let rivet = (head + body) - cylinder([0, 0, -length - 1.0], "Z", mandrel_d / 2.0 + 0.1, length + 5.0);
let mandrel = cylinder([0, 0, -length - 1.0], "Z", mandrel_d / 2.0, length + 26.0) + sphere([0, 0, -length - 1.0], mandrel_d * 0.7);
[rivet, mandrel]
