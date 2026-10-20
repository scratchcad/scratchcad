// Makeup brush stand: 7 holes (3 x 12 mm, 4 x 9 mm) in a 100 mm round puck 30 mm tall with a 20 degree top bevel
let d = 100.0; // [70.0, 140.0] Puck diameter (mm)
let height = 30.0; // [20.0, 45.0] Height (mm)
let p = cylinder(d / 2.0, height);
let pp = p.chamfer(6.0, p.edges(">Z"));
let holes = [cylinder([0, 0, 6.0], "Z", 6.0, height)];
for k in 0..2 { holes.push(cylinder([(k.to_float() * 2.0 - 1.0) * 22.0, 0, 6.0], "Z", 6.0, height)); }
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([30.0 * a.cos(), 30.0 * a.sin(), 6.0], "Z", 4.5, height)); }
pp - compound(holes)
