// Stirrup tread pad: 120 x 50 mm, 8 mm thick, 12 x 4 diamond grip studs 2 mm, 4 snap pegs 6 mm
let length = 120.0; // [100.0, 140.0] Pad length (mm)
let width = 50.0; // [40.0, 65.0] Pad width (mm)
let t = 8.0; // [5.0, 12.0] Thickness (mm)
let pad = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = pad.fillet(width / 2.0 - 1.0, pad.edges("|Z"));
let studs = [];
for i in 0..12 { for j in 0..4 { studs.push(box_centered(3.5, 3.5, 2.0).rotate_z(45.0).translate([-length / 2.0 + 15.0 + i.to_float() * 8.2, -width / 2.0 + 13.0 + j.to_float() * 8.0, t + 0.99])); } }
let pegs = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { pegs.push(cylinder([sx * 40.0, sy * 12.0, -6.0], "Z", 3.0, 6.01)); } }
p + (compound(studs) & p.translate([0, 0, 2.0])) + fuse_all(pegs)
