// Entryway key dish: 150 mm round, 30 mm tall, 3 mm wall, flared rim, 3 rubber feet bosses
let diameter = 150.0; // [100.0, 220.0] Diameter (mm)
let height = 30.0; // [20.0, 50.0] Height (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let r = diameter / 2.0;
let p = sketch("XZ").move_to(0, 0).hline_to(r * 0.7).arc_to(r * 0.93, height * 0.35, r, height).hline_to(r - wall).arc_to(r * 0.93 - wall, height * 0.35 + wall * 0.5, r * 0.7 - wall * 0.4, wall).hline_to(0).close();
let dish = p.face().revolve("Z", 360);
let feet = [];
for k in 0..3 { let a = (k.to_float() * 120.0) * PI() / 180.0; feet.push(cylinder([r * 0.5 * a.cos(), r * 0.5 * a.sin(), -2.0], "Z", 6.0, 2.01)); }
dish + fuse_all(feet)
