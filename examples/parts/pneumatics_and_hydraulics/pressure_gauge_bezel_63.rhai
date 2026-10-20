// 63 mm pressure gauge bezel ring: 68 mm OD, 61 mm window, 8 mm deep, snap lip 1 mm, 3 bayonet lugs
let od = 68.0; // [45.0, 110.0] Bezel OD (mm)
let window = 61.0; // [38.0, 100.0] Window (mm)
let depth = 8.0; // [5.0, 12.0] Depth (mm)
let ring = cylinder(od / 2.0, depth) - cylinder([0, 0, -1], "Z", od / 2.0 - 2.0, depth - 1.0) - cylinder([0, 0, -1], "Z", window / 2.0, depth + 2.0);
let lugs = [];
for k in 0..3 { lugs.push(box_from_corners([od / 2.0 - 3.5, -4.0, 0], [od / 2.0 - 1.99, 4.0, 1.5]).rotate_z(k.to_float() * 120.0)); }
ring + fuse_all(lugs)
