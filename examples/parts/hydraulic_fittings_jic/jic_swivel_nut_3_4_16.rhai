// JIC -08 swivel nut, 3/4-16 UNF: 22.2 mm AF hex 17 mm long with a 19.05 mm thread bore (17.5 mm minor) 13 mm deep, 12.8 mm tube clearance, a conical step to the bore and 1 mm chamfered hex ends
let af = 22.2; // [19.0, 28.6] Hex across flats (mm)
let length = 17.0; // [14.0, 22.0] Nut length (mm)
let thread_d = 17.5; // [15.0, 22.0] Thread minor diameter (mm)
let r = af / 2.0 / cos(PI() / 6.0);
let pts = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; pts.push([r * cos(a), r * sin(a), 0]); }
let hex = face(polygon(pts)).extrude([0, 0, length]);
let hex = hex.chamfer(1.0, hex.edges(">Z or <Z"));
hex - cylinder([0, 0, -1.0], "Z", thread_d / 2.0, length - 3.0) - cylinder([0, 0, -1.0], "Z", 6.4, length + 2.0) - cone(thread_d / 2.0, 6.4, 2.0).translate([0, 0, length - 4.01])
