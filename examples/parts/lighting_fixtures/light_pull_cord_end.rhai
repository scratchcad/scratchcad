// Bathroom light pull cord end: 40 mm teardrop 18 mm diameter, 2.5 mm cord hole with a 6 mm knot pocket in the bottom
let length = 40.0; // [25.0, 60.0] Length (mm)
let d = 18.0; // [12.0, 25.0] Max diameter (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(2.5).line_to(d / 2.0, length * 0.6).arc_to(d / 2.0 - 2.0, length * 0.85, 0, length).close();
let body = p.face().revolve("Z", 360);
body - cylinder([0, 0, -1], "Z", 1.25, length + 2.0) - cylinder([0, 0, -1], "Z", 3.0, length * 0.5)
