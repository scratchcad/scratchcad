// Stand mixer bowl clamp plate: 120 mm bayonet ring 4 mm, 3 locking tabs 12 mm, 90 mm center opening
let od = 120.0; // [90.0, 160.0] Ring diameter (mm)
let opening = 90.0; // [60.0, 120.0] Center opening (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let ring = cylinder(od / 2.0, t) - cylinder([0, 0, -1], "Z", opening / 2.0, t + 2.0);
let tabs = [];
for k in 0..3 { tabs.push((box_from_corners([opening / 2.0 - 6.0, -10.0, t - 0.01], [opening / 2.0 + 2.0, 10.0, t + 6.0]) - box_from_corners([opening / 2.0 - 7.0, -11.0, t + 1.5], [opening / 2.0 - 2.0, 11.0, t + 4.0])).rotate_z(k.to_float() * 120.0)); }
ring + fuse_all(tabs)
