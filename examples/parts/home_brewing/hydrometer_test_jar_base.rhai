// Hydrometer test jar foot: fits a 40 mm jar, 80 mm wide 3-lobe base 6 mm, 15 mm socket with a 2 mm drain notch
let jar = 40.0; // [30.0, 60.0] Jar diameter (mm)
let span = 80.0; // [60.0, 120.0] Base span (mm)
let lobes = [];
for k in 0..3 { lobes.push(box_from_corners([0, -10.0, 0], [span / 2.0, 10.0, 6.0]).rotate_z(k.to_float() * 120.0)); }
let tips = [];
for k in 0..3 { let a = (k.to_float() * 120.0) * PI() / 180.0; tips.push(cylinder([span / 2.0 * a.cos(), span / 2.0 * a.sin(), 0], "Z", 10.0, 6.0)); }
let socket = cylinder(jar / 2.0 + 3.0, 21.0) - cylinder([0, 0, 6.0], "Z", jar / 2.0 + 0.3, 16.0);
fuse_all(lobes) + fuse_all(tips) + socket - box_from_corners([-1.0, 0, 6.0], [1.0, jar, 21.0 + 1.0])
