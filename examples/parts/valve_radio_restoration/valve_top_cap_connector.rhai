// Valve top cap connector: 9.5 mm grid cap clip 12 mm tall, 0.8 mm brass-style wall with 4 spring slits, a 14 mm insulating shroud and a 3 mm lead exit
let cap = 9.5; // [6.0, 14.0] Valve top cap diameter (mm)
let height = 12.0; // [8.0, 18.0] Connector height (mm)
let clip = cylinder([0, 0, 0], "Z", cap / 2.0 + 0.8, height * 0.6) - cylinder([0, 0, -1.0], "Z", cap / 2.0 - 0.1, height * 0.6);
let slits = [];
for i in 0..4 { slits.push(box_centered(0.8, cap, height * 0.4).translate([0, 0, height * 0.2 - 0.01]).rotate_z(i.to_float() * 45.0)); }
let shroud = cylinder([0, 0, 0], "Z", 7.0, height) - cylinder([0, 0, -1.0], "Z", cap / 2.0 + 1.5, height * 0.6 + 1.0);
let joiner = cylinder([0, 0, height * 0.6 - 1.0], "Z", 7.0, 1.01);
clip - fuse_all(slits) + shroud + joiner - cylinder([0, 0, height - 3.0], "Z", 1.5, 4.0)
