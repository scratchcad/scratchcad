// Badminton shuttlecock: 25 mm cork base with a domed nose, 16 feathers approximated by a 1 mm truncated-cone skirt from 26 to 66 mm across, 62 mm long
let skirt_top = 66.0; // [58.0, 68.0] Skirt diameter (mm)
let base2 = (cylinder([0, 0, 12.0], "Z", 12.5, 13.0) + sphere([0, 0, 12.0], 12.5)) & box_centered(30.0, 30.0, 30.0).translate([0, 0, 15.0]);
let skirt = cone(13.0, skirt_top / 2.0, 62.0).translate([0, 0, 24.0]) - cone(12.0, skirt_top / 2.0 - 1.0, 62.1).translate([0, 0, 24.0]);
let cuts = [];
for k in 0..16 { cuts.push(box_centered(3.0, 2.0, 20.0).translate([skirt_top / 2.0 - 2.0, 0, 80.0]).rotate_z(k.to_float() * 22.5)); }
fuse_all([base2, skirt - fuse_all(cuts)])
