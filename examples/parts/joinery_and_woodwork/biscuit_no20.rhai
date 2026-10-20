// No. 20 joining biscuit: 56 x 23 x 4 mm lens, compressed-beech style with a diamond grain pattern
let length = 56.0; // [47.0, 60.0] Length (mm)
let width = 23.0; // [15.0, 24.0] Width (mm)
let t = 4.0; // [3.5, 4.5] Thickness (mm)
let r = (length * length / 4.0 + width * width / 4.0) / width;
let a = cylinder([0, width / 2.0 - r, -t / 2.0], "Z", r, t) & cylinder([0, -width / 2.0 + r, -t / 2.0], "Z", r, t);
let grooves = [];
for k in -4..=4 { grooves.push(box_centered(0.4, width * 2.0, 0.6).rotate_z(45.0).translate([k.to_float() * 6.0, 0, t / 2.0])); }
a - fuse_all(grooves)
