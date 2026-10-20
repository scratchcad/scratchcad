// Eccentric spacer for V-slot wheels: 6.35 mm hex head, 7.12 mm bore offset 0.79 mm, M5 through hole
let length = 6.0; // [3.0, 12.0] Length (mm)
let across_flats = 8.0; // [6.0, 14.0] Hex size (mm)
let boss_d = 7.12; // [6.0, 10.0] Boss diameter (mm)
let offset = 0.79; // [0.4, 1.5] Eccentricity (mm)
let hole_d = 5.1; // [3.0, 6.0] Hole diameter (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let head = polygon(pts).to_face().extrude(length);
let boss = cylinder([offset, 0, length - 0.01], "Z", boss_d / 2.0, 2.0);
(head + boss) - cylinder([0, 0, -1], "Z", hole_d / 2.0, length + 4.0)
