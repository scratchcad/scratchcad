// Hair roller core: 32 mm diameter 65 mm long, 1.2 mm perforated shell with 8 x 5 rows of 4 mm holes, end rings
let d = 32.0; // [15.0, 60.0] Roller diameter (mm)
let length = 65.0; // [40.0, 90.0] Length (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let shell = cylinder(d / 2.0, length) - cylinder([0, 0, -1], "Z", d / 2.0 - wall, length + 2.0);
let holes = [];
for i in 0..5 { for k in 0..8 { holes.push(cylinder([0, 0, 10.0 + i.to_float() * (length - 20.0) / 4.0], "X", 2.0, d).rotate_z(k.to_float() * 45.0 + (i % 2).to_float() * 22.5)); } }
let rings = (cylinder(d / 2.0 + 1.0, 2.0) - cylinder([0, 0, -1], "Z", d / 2.0 - wall, 4.0)) + (cylinder([0, 0, length - 2.0], "Z", d / 2.0 + 1.0, 2.0) - cylinder([0, 0, length - 3.0], "Z", d / 2.0 - wall, 4.0));
shell - fuse_all(holes) + rings
