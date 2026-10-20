// Golf ball marker: 25 mm disc 2.5 mm thick with 0.6 mm chamfered edges, a 0.4 mm alignment arrow engraved on top and a 10 x 1.5 mm magnet pocket underneath
let dia = 25.0; // [18.0, 32.0] Marker diameter (mm)
let magnet = 10.0; // [6.0, 12.0] Magnet diameter (mm)
const t = 2.5;
let d = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let d = d.chamfer(0.6, d.edges("%CIRCLE"));
let arrow = face(polygon([[0, dia * 0.32, 0], [-dia * 0.12, dia * 0.12, 0], [-dia * 0.04, dia * 0.12, 0], [-dia * 0.04, -dia * 0.3, 0], [dia * 0.04, -dia * 0.3, 0], [dia * 0.04, dia * 0.12, 0], [dia * 0.12, dia * 0.12, 0]])).extrude([0, 0, 1.0]).translate([0, 0, t - 0.4]);
d - arrow - cylinder([0, 0, -1.0], "Z", magnet / 2.0 + 0.1, 2.5)
