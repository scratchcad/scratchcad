// Roman blind sew-on cord ring: 12 mm OD, 8 mm ID, 1.5 mm thick flat ring with 4 sewing notches
let od = 12.0; // [8.0, 20.0] Outside diameter (mm)
let id = 8.0; // [5.0, 15.0] Inside diameter (mm)
let t = 1.5; // [1.0, 2.5] Thickness (mm)
let ring = cylinder(od / 2.0, t) - cylinder([0, 0, -1], "Z", id / 2.0, t + 2.0);
let notches = [];
for k in 0..4 { notches.push(box_centered(1.0, 1.0, t + 2.0).translate([od / 2.0, 0, t / 2.0]).rotate_z(k.to_float() * 90.0 + 45.0)); }
ring - compound(notches)
