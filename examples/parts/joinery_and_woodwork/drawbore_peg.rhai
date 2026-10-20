// Drawbore oak peg: 3/8 in (9.5 mm) octagonal peg 90 mm long, tapered 20 mm point
let d = 9.5; // [6.0, 16.0] Peg size across flats (mm)
let length = 90.0; // [50.0, 150.0] Length (mm)
let pts = [];
for i in 0..8 { let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0; pts.push([d / 2.0 / (22.5 * PI() / 180.0).cos() * a.cos(), d / 2.0 / (22.5 * PI() / 180.0).cos() * a.sin()]); }
let peg = polygon(pts).to_face().extrude([0, 0, length]);
peg & (cone(1.5, d, 20.0) + cylinder([0, 0, 19.99], "Z", d, length))
