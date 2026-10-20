// No. 1 craft knife handle: 8 mm aluminium-style handle, 120 mm, knurl rings, collet split 4 slots
let length = 120.0; // [90.0, 150.0] Length (mm)
let diameter = 8.0; // [6.0, 12.0] Diameter (mm)
let collet_l = 18.0; // [12.0, 25.0] Collet length (mm)
let body = cylinder(diameter / 2.0, length);
let tip = cone(diameter / 2.0, diameter / 2.0 - 1.2, collet_l).translate([0, 0, length - 0.01]);
let rings = [];
for k in 0..12 { rings.push(cylinder([0, 0, 20.0 + k.to_float() * 4.0], "Z", diameter, 1.2) - cylinder([0, 0, 19.0 + k.to_float() * 4.0], "Z", diameter / 2.0 - 0.4, 4.0)); }
let slots = [];
for k in 0..2 { slots.push(box_centered(0.8, diameter + 2.0, collet_l).translate([0, 0, length + collet_l / 2.0 + 2.0]).rotate_z(k.to_float() * 90.0)); }
body + tip - compound(rings) - fuse_all(slots) - cylinder([0, 0, length - 10.0], "Z", 1.2, collet_l + 12.0)
