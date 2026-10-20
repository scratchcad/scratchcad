// MK8 drive gear: 9 mm OD, 11 mm long, 5 mm bore, 26-tooth hobbed groove at 7 mm, M3 grub screw
let outer = 9.0; // [7.0, 12.0] Outside diameter (mm)
let length = 11.0; // [8.0, 15.0] Length (mm)
let bore = 5.0; // [3.0, 6.0] Bore (mm)
let teeth = 26; // [16, 40] Teeth
let groove_z = 7.0; // [4.0, 10.0] Groove height (mm)
let gear = cylinder(outer / 2.0, length) - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0);
let cuts = [];
for i in 0..teeth { cuts.push(box_centered(0.5, 0.5, 3.0).rotate_z(45).translate([outer / 2.0, 0, groove_z]).rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
gear = gear - fuse_all(cuts) - torus(outer / 2.0 + 0.3, 0.9).translate([0, 0, groove_z]);
gear - cylinder([0, 0, 2.5], "X", 1.25, outer)
