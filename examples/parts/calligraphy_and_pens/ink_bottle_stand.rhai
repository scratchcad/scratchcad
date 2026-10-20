// Ink bottle anti-tip stand: 100 mm hexagonal base 8 mm thick with a 52 mm bottle socket 12 mm deep and a 12 mm pen rest groove along the front
let bottle = 52.0; // [35.0, 70.0] Bottle diameter (mm)
let base = 100.0; // [80.0, 140.0] Base across corners (mm)
const t = 8.0;
let pts = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; pts.push([base / 2.0 * cos(a), base / 2.0 * sin(a), 0]); }
let b = face(polygon(pts)).extrude([0, 0, t]);
let ring = cylinder([0, 8.0, t - 0.01], "Z", bottle / 2.0 + 3.0, 12.0 - t + 4.0);
let grooves = cylinder([-base / 2.0, -base * 0.3, t + 2.0], "X", 6.0, base);
b + ring - cylinder([0, 8.0, 4.0], "Z", bottle / 2.0 + 0.3, 20.0) - grooves
