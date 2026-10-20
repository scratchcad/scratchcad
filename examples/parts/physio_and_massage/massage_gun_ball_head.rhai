// Massage gun ball attachment: 50 mm ball head flattened 3 mm at the base, on a 12 mm push-fit shank 25 mm long with two 0.8 mm O-ring grooves
let ball = 50.0; // [35.0, 60.0] Ball diameter (mm)
let shank = 12.0; // [10.0, 15.0] Shank diameter (mm)
let r = ball / 2.0;
let head = sphere([0, 0, r], r) - box_centered(3.0 * r, 3.0 * r, r).translate([0, 0, -r / 2.0 + 3.0]);
let s = cylinder([0, 0, -25.0], "Z", shank / 2.0, 28.01);
let grooves = [];
for z in [-20.0, -12.0] { grooves.push(cylinder([0, 0, z], "Z", shank / 2.0 + 1.0, 1.6) - cylinder([0, 0, z - 1.0], "Z", shank / 2.0 - 0.8, 4.0)); }
head + s - fuse_all(grooves)
