// Camlock coupling type A, 1 in: 40 mm adapter with a 49 mm groove section, 1 in BSP female, 70 mm long
let outer_d = 49.0; // [30.0, 110.0] Coupling OD (mm)
let groove_d = 44.0; // [26.0, 100.0] Groove diameter (mm)
let length = 70.0; // [40.0, 120.0] Length (mm)
let bore = 25.0; // [12.0, 80.0] Bore (mm)
let body = cylinder(outer_d / 2.0, length * 0.45) + cylinder([0, 0, length * 0.45 - 0.01], "Z", outer_d / 2.0 - 4.0, length * 0.55);
body = body - (cylinder([0, 0, length * 0.15], "Z", outer_d / 2.0 + 1.0, 6.0) - cylinder([0, 0, 0], "Z", groove_d / 2.0, length));
let rc = (outer_d - 2.0) / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
body = body + polygon(pts).to_face().extrude(12.0).translate([0, 0, length - 12.0]) & cylinder(outer_d / 2.0 + 0.5, length);
body - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0) - cylinder([0, 0, length - 18.0], "Z", 33.25 / 2.0, 19.0)
