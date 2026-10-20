// Hydroponic net pot, 2 in: 50 mm rim, 45 mm top, 35 mm base, 50 mm tall, 1.2 mm wall, slotted sides
let top_d = 45.0; // [30.0, 80.0] Top diameter (mm)
let base_d = 35.0; // [20.0, 60.0] Base diameter (mm)
let height = 50.0; // [30.0, 80.0] Height (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let cup = cone(base_d / 2.0, top_d / 2.0, height) + cylinder([0, 0, height - 2.0], "Z", top_d / 2.0 + 2.5, 2.0);
let c = cup - cone(base_d / 2.0 - wall, top_d / 2.0 - wall, height).translate([0, 0, wall]) - cylinder([0, 0, height - 2.0], "Z", top_d / 2.0 - wall, 5.0);
let slots = [];
for k in 0..12 { slots.push(box_centered(3.0, top_d, height - 14.0).translate([0, 0, height / 2.0 - 1.0]).rotate_z(k.to_float() * 15.0)); }
let bottom_slots = [];
for k in 0..3 { bottom_slots.push(box_centered(3.0, base_d - 10.0, 6.0).translate([(k.to_float() - 1.0) * 7.0, 0, 0])); }
c - fuse_all(slots) - fuse_all(bottom_slots)
