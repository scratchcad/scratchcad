// Bench capper bell for 26 mm crown caps: 32 mm bell 20 mm tall, 26.5 mm recess with 21 flute ribs 1 mm, 10 mm shaft socket
let cap = 26.5; // [26.0, 29.5] Crown cap diameter (mm)
let height = 20.0; // [15.0, 30.0] Bell height (mm)
let b = cylinder(16.0, height) - cylinder([0, 0, -1], "Z", cap / 2.0, 8.0) - cone(cap / 2.0, 8.0, 4.0).translate([0, 0, 6.99]);
let ribs = [];
for k in 0..21 { ribs.push(box_centered(1.0, 1.0, 6.5).translate([cap / 2.0 - 0.4, 0, 3.26]).rotate_z(k.to_float() * 360.0 / 21.0)); }
b + fuse_all(ribs) - cylinder([0, 0, height - 12.0], "Z", 5.0, 13.0)
