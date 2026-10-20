// Corner steady brace socket: 19 mm AF hex socket 15 mm deep in a 30 mm body 40 mm long, with a 12 mm square drive at the top end and a 6 mm cross hole for a tommy bar
let af = 19.0; // [17.0, 24.0] Hex across flats (mm)
let depth = 15.0; // [10.0, 22.0] Socket depth (mm)
const body_l = 40.0;
let od = af / cos(PI() / 6.0) + 6.0;
let b = cylinder([0, 0, 0], "Z", od / 2.0, body_l);
let hr = af / 2.0 / cos(PI() / 6.0) + 0.2;
let pts = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; pts.push([hr * cos(a), hr * sin(a), 0]); }
let hex = face(polygon(pts)).extrude([0, 0, depth + 1.0]).translate([0, 0, -1.0]);
let drive = box_centered(12.2, 12.2, 14.0).translate([0, 0, body_l - 6.0]);
b - hex - drive - cylinder([-od, 0, depth + 6.0], "X", 3.0, 2.0 * od)
