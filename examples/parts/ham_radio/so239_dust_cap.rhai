// SO-239 dust cap: 5/8-24 thread boss cover 17 mm ID, 13 mm deep, 20 mm OD with 12 grip flutes
let id = 16.2; // [15.0, 18.0] Bore (mm)
let depth = 13.0; // [8.0, 18.0] Depth (mm)
let od = 20.0; // [18.0, 26.0] Outside diameter (mm)
let c = cylinder(od / 2.0, depth + 2.0) - cylinder([0, 0, -1], "Z", id / 2.0, depth + 1.0);
let flutes = [];
for k in 0..12 { flutes.push(cylinder([od / 2.0 + 0.3, 0, -1], "Z", 1.0, depth).rotate_z(k.to_float() * 30.0)); }
c - compound(flutes)
