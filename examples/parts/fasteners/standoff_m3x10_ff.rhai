// M3 x 10 hex standoff, female-female: 5.5 mm AF brass, 2.5 mm tapped through
let across_flats = 5.5; // [4.0, 10.0] Width across flats (mm)
let length = 10.0; // [3.0, 50.0] Length (mm)
let bore = 2.5; // [1.6, 5.0] Tap drill (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
polygon(pts).to_face().extrude(length).chamfer(0.25, "(>Z or <Z) and not %CIRCLE") - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0)
