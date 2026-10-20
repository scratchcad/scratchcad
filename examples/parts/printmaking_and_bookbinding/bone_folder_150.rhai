// Bookbinding bone folder: 150 x 25 x 4 mm with one rounded end and one 40 mm tapered point, edges eased 1 mm
let length = 150.0; // [100.0, 200.0] Folder length (mm)
let width = 25.0; // [18.0, 32.0] Folder width (mm)
const t = 4.0;
let r = width / 2.0;
let outline = sketch("XY").move_to(0, -r).hline_to(length - 40.0).line_to(length, -2.0).vline_to(2.0).line_to(length - 40.0, r).hline_to(0).arc_to(-r, 0, 0, -r).close();
let f = face(outline).extrude([0, 0, t]);
f.fillet(1.0, f.edges("#Z"))
