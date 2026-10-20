// Truss rod cover, 3-hole bell shape: 38 mm long, about 26 mm wide at the bell, 13 mm at the narrow end, 1.5 mm thick with three 2.2 mm screw holes and a 0.6 mm edge bevel
let length = 38.0; // [30.0, 40.0] Cover length (mm)
let bell = 30.0; // [24.0, 36.0] Bell width (mm)
const t = 1.5;
let outline = sketch("XY").move_to(-6.5, 0).line_to(-bell / 2.0 + 2.0, length - 12.0).arc_to(0, length, bell / 2.0 - 2.0, length - 12.0).line_to(6.5, 0).close();
let c = face(outline).extrude([0, 0, t]);
let c = c.chamfer(0.6, c.edges(">Z"));
c - cylinder([0, 4.0, -1.0], "Z", 1.1, t + 2.0) - cylinder([-bell / 2.0 + 6.0, length - 10.0, -1.0], "Z", 1.1, t + 2.0) - cylinder([bell / 2.0 - 6.0, length - 10.0, -1.0], "Z", 1.1, t + 2.0)
