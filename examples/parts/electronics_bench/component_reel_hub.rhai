// SMD tape reel hub adapter: 13 mm EIA spindle to a 25 mm shaft, 3 key ribs, 20 mm long
let spindle = 13.0; // [10.0, 16.0] Reel bore (mm)
let shaft = 6.0; // [4.0, 10.0] Holder shaft (mm)
let length = 20.0; // [12.0, 30.0] Length (mm)
let hub = cylinder(spindle / 2.0 - 0.1, length) + cylinder(spindle / 2.0 + 4.0, 2.0);
let keys = [];
for k in 0..3 { keys.push(box_from_corners([spindle / 2.0 - 0.5, -1.0, 1.99], [spindle / 2.0 + 0.8, 1.0, length]).rotate_z(k.to_float() * 120.0)); }
hub + fuse_all(keys) - cylinder([0, 0, -1], "Z", shaft / 2.0, length + 2.0)
