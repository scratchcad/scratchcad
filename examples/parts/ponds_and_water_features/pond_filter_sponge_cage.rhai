// Pond filter sponge holder: 150 x 150 mm square tray 50 mm deep, 2.5 mm walls, slotted floor with 12 slots 6 mm wide, and a 20 mm overflow notch on one side
let size = 150.0; // [100.0, 250.0] Tray size (mm)
let depth = 50.0; // [30.0, 80.0] Tray depth (mm)
const wall = 2.5;
let tray = box_centered(size, size, depth).translate([0, 0, depth / 2.0]) - box_centered(size - 2.0 * wall, size - 2.0 * wall, depth).translate([0, 0, depth / 2.0 + wall]);
let slots = [];
for i in 0..12 { slots.push(box_centered(size - 20.0, 6.0, wall + 2.0).translate([0, -size / 2.0 + 15.0 + i.to_float() * (size - 30.0) / 11.0, wall / 2.0])); }
tray - fuse_all(slots) - box_centered(20.0, wall + 2.0, 10.0).translate([0, size / 2.0 - wall / 2.0, depth - 5.0 + 0.01])
