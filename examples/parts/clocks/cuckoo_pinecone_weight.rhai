// Cuckoo clock pine cone weight: 30 mm diameter, 110 mm long, 6 rows of scales, 6 mm top hook loop
let d = 30.0; // [20.0, 45.0] Cone diameter (mm)
let length = 110.0; // [70.0, 160.0] Length (mm)
let body = cylinder([0, 0, 15.0], "Z", d / 2.0, length - 30.0) + cone(3.0, d / 2.0, 15.01) + cone(d / 2.0, 6.0, 15.0).translate([0, 0, length - 15.01]);
let scales = [];
for row in 0..6 {
    let z = 22.0 + row.to_float() * (length - 44.0) / 5.0;
    for k in 0..8 { scales.push(sphere([d / 2.0 + 0.5, 0, z], 4.0).rotate_z(k.to_float() * 45.0 + (row % 2).to_float() * 22.5)); }
}
let loop_ = cylinder([0, -1.5, length + 3.5], "Y", 5.0, 3.0) - cylinder([0, -2.0, length + 3.5], "Y", 3.0, 4.0);
body + fuse_all(scales) + loop_
