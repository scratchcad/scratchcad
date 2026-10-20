// Rear lens cap for a PL-mount cine lens: 64 mm cap 20 mm tall, 2 mm walls, 54.2 mm socket for the lens's 54 mm PL flange spigot 6 mm deep, four 3 mm bayonet ear notches, and 24 grip flutes round the outside
let cap_d = 64.0; // [60.0, 80.0] Cap diameter (mm)
let height = 20.0; // [12.0, 35.0] Cap height (mm)
let flutes = 24; // [0, 36] Number of grip flutes
const wall = 2.0;
const socket_d = 54.2;
const socket_depth = 6.0;
let r = cap_d / 2.0;
let cup = cylinder([0, 0, 0], "Z", r, height) - cylinder([0, 0, wall], "Z", r - wall, height);
let collar = cylinder([0, 0, height - socket_depth - 1.0], "Z", r, socket_depth + 1.0) - cylinder([0, 0, height - socket_depth - 2.0], "Z", socket_d / 2.0, socket_depth + 3.0);
let cap = cup + collar;
let cuts = [];
for i in 0..4 {
    cuts.push(box_centered(8.0, 6.0, socket_depth + 1.0).translate([socket_d / 2.0 + 1.5, 0, height - socket_depth / 2.0 + 0.5]).rotate_z(i.to_float() * 90.0 + 45.0));
}
for i in 0..flutes {
    cuts.push(cylinder([r + 0.6, 0, wall + 1.0], "Z", 1.5, height).rotate_z(i.to_float() * 360.0 / max(flutes, 1).to_float()));
}
cap - fuse_all(cuts)
