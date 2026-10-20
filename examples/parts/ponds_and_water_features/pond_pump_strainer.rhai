// Pond pump pre-filter strainer cage: 80 mm dia 100 mm tall cylinder, 2 mm walls, 32 vertical slots 3 mm wide around it, closed base and a 25 mm hose spigot on the lid
let dia = 80.0; // [50.0, 120.0] Strainer diameter (mm)
let height = 100.0; // [60.0, 150.0] Strainer height (mm)
const wall = 2.0;
let body = cylinder([0, 0, 0], "Z", dia / 2.0, height) - cylinder([0, 0, wall], "Z", dia / 2.0 - wall, height - 2.0 * wall);
let slots = [];
for i in 0..16 { slots.push(box_centered(dia + 2.0, 3.0, height - 20.0).translate([0, 0, height / 2.0]).rotate_z(i.to_float() * 11.25)); }
let spigot = cylinder([0, 0, height - 0.01], "Z", 12.5, 25.0) - cylinder([0, 0, height - wall - 1.0], "Z", 10.5, 30.0);
body - fuse_all(slots) + spigot
