// Leather edge creaser handle: 110 mm octagonal handle 22 mm, 3 mm tip socket 15 mm deep, 18 mm ferrule
let length = 110.0; // [80.0, 140.0] Handle length (mm)
let d = 22.0; // [16.0, 30.0] Handle size (mm)
let pts = [];
for i in 0..8 { let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0; pts.push([d / 2.0 * a.cos(), d / 2.0 * a.sin()]); }
let h = polygon(pts).to_face().extrude([0, 0, length]);
let hh = h & (cone(9.0, d * 0.8, 25.0) + cylinder([0, 0, 24.99], "Z", d, length - 39.98) + cone(d * 0.8, 7.0, 15.01).translate([0, 0, length - 15.0]));
let ferrule = cylinder([0, 0, -10.0], "Z", 9.0, 10.01);
hh + ferrule - cylinder([0, 0, -11.0], "Z", 1.5, 16.0)
