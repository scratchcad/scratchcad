// Game counter token: 25 mm disc 4 mm, 1 mm raised rim, center star relief 0.6 mm
let d = 25.0; // [15.0, 40.0] Token diameter (mm)
let t = 4.0; // [2.0, 6.0] Thickness (mm)
let token = cylinder(d / 2.0, t);
let well = cylinder([0, 0, t - 0.8], "Z", d / 2.0 - 1.5, 1.0);
let pts = [];
for i in 0..10 { let a = (i.to_float() * 36.0 + 90.0) * PI() / 180.0; let r = if i % 2 == 0 { d * 0.3 } else { d * 0.12 }; pts.push([r * a.cos(), r * a.sin()]); }
let star = polygon(pts).to_face().extrude([0, 0, 0.6]).translate([0, 0, t - 0.81]);
token - well + star
