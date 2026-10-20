// Open star piping tip (1M): 45 mm tall cone 23 mm base to 10 mm tip, 0.8 mm wall, 8-point star opening 8.5 mm
let height = 45.0; // [30.0, 60.0] Tip height (mm)
let base = 23.0; // [18.0, 30.0] Base diameter (mm)
let tip = 10.0; // [6.0, 16.0] Tip outside diameter (mm)
let wall = 0.8; // [0.5, 1.2] Wall (mm)
let points = 8; // [5, 12] Number of star points
let shell = cone(base / 2.0, tip / 2.0, height) - cone(base / 2.0 - wall, tip / 2.0 - wall, height + 0.02).translate([0, 0, -0.01]);
let pts = [];
for i in 0..(2 * points) { let a = (i.to_float() * 180.0 / points.to_float()) * PI() / 180.0; let r = if i % 2 == 0 { tip / 2.0 - wall - 0.2 } else { tip / 2.0 - wall - 1.6 }; pts.push([r * a.cos(), r * a.sin()]); }
let star = polygon(pts).to_face().extrude([0, 0, 3.0]).translate([0, 0, height - 3.0]);
let cap = cylinder([0, 0, height - 3.0], "Z", tip / 2.0 - wall + 0.01, 3.0) - star;
shell + cap
