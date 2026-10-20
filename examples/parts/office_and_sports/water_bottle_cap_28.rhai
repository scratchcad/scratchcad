// PCO 1881 28 mm bottle cap: 30 mm OD, 12 mm tall, 2 mm top, 120 grip ribs, inner bore 25 mm with two thread ridges and a sealing bore plug
let od = 30.0; // [28.0, 38.0] Cap outer diameter (mm)
let h = 12.0; // [10.0, 16.0] Cap height (mm)
let cap = cylinder(od / 2.0, h).chamfer(0.5, ">Z") - cylinder([0, 0, -1], "Z", 12.6, h - 1.0);
let ribs = [];
for k in 0..60 { ribs.push(cylinder([od / 2.0 + 0.15, 0, -1], "Z", 0.35, h - 1.0).rotate_z(k.to_float() * 6.0)); }
cap = cap - fuse_all(ribs);
cap = cap + (torus(12.6, 0.6).translate([0, 0, 3.0]) & cylinder(12.6, h)) + (torus(12.6, 0.6).translate([0, 0, 6.0]) & cylinder(12.6, h));
cap + (cylinder([0, 0, h - 5.0], "Z", 11.2, 3.0) - cylinder([0, 0, h - 6.0], "Z", 10.4, 5.0))
