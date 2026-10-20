// Coarse sun sensor housing: 20 x 20 x 6 mm block, 4 photodiode pockets 3.5 mm at 45 degree tilt, aperture plate slot
let size = 20.0; // [15.0, 30.0] Block size (mm)
let height = 6.0; // [4.0, 10.0] Height (mm)
let pd = 3.5; // [2.0, 5.0] Photodiode diameter (mm)
let b = box_centered(size, size, height).translate([0, 0, height / 2.0]);
let pockets = [];
for k in 0..4 { pockets.push(cylinder([0, 0, 0], "Z", pd / 2.0, 10.0).rotate_y(-45.0).translate([size / 5.0, 0, height * 0.35]).rotate_z(k.to_float() * 90.0)); }
b - fuse_all(pockets) - box_centered(size - 4.0, size - 4.0, 0.6).translate([0, 0, height - 0.6]) - cylinder([size / 2.0 - 2.0, size / 2.0 - 2.0, -1], "Z", 1.1, height + 2.0) - cylinder([-size / 2.0 + 2.0, -size / 2.0 + 2.0, -1], "Z", 1.1, height + 2.0)
