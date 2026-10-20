// Wheelie bin wheel hub cap: 60 mm push-on cap 12 mm tall for a 200 mm bin wheel, 2 mm walls, 25 mm axle boss bore 20.5 mm with 4 snap fingers
let cap = 60.0; // [45.0, 80.0] Cap diameter (mm)
let axle = 20.5; // [15.0, 25.0] Axle end diameter (mm)
const wall = 2.0;
let c = cylinder([0, 0, 0], "Z", cap / 2.0, 12.0) - cylinder([0, 0, -1.0], "Z", cap / 2.0 - wall, 12.0 - wall + 1.0);
let boss = cylinder([0, 0, 0], "Z", axle / 2.0 + 2.5, 12.0) - cylinder([0, 0, -1.0], "Z", axle / 2.0, 12.0);
let slits = [];
for i in 0..4 { slits.push(box_centered(1.2, axle / 2.0 + 4.0, 8.0).translate([0, axle / 4.0 + 2.0, 3.0]).rotate_z(i.to_float() * 90.0 + 45.0)); }
c + boss - fuse_all(slits)
