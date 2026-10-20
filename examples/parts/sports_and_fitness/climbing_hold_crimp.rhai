// Climbing hold, small crimp: 80 mm wide, 38 mm tall on the wall, 22 mm deep, 18 mm incut edge 12 mm deep, 10.5 mm bolt hole with a 24 mm counterbore 12 mm deep
let width = 80.0; // [50.0, 120.0] Width (mm)
let height = 38.0; // [25.0, 60.0] Height on the wall (mm)
let depth = 22.0; // [14.0, 35.0] Depth off the wall (mm)
let edge = 12.0; // [6.0, 20.0] Crimp edge depth (mm)
let incut = 8.0; // [0.0, 15.0] Incut angle (degrees)
const bolt_d = 10.5;
const cb_d = 24.0;
let e = min(edge, depth - 4.0);
let tan_i = (incut * PI() / 180.0).tan();
// side profile in Y (up the wall) and Z (off the wall): sloping back face, flat-ish incut edge at the top
let side = sketch("YZ").move_to(0, 0).line_to(height * 0.55, depth).line_to(height * 0.55 + e, depth - e * tan_i).line_to(height, depth * 0.35).line_to(height, 0).close();
let hold = side.to_face().extrude([width, 0, 0]).translate([-width / 2.0, -height / 2.0, 0]);
let plan = box_centered(width, height + 2.0, depth * 3.0).fillet(min(height / 2.0, 18.0), "|Z");
hold = hold & plan;
hold = hold - cylinder([0, 0, -1.0], "Z", bolt_d / 2.0, depth + 2.0) - cylinder([0, 0, depth * 0.45], "Z", cb_d / 2.0, depth);
hold
