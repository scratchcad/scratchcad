// Trolley castor kingpin dust cap: 28 mm cap 4 mm thick with a 1 mm chamfer and a 12 mm push-in spigot 10 mm long split by two 1.5 mm slots so it springs into the hollow kingpin
let cap_d = 28.0; // [20.0, 40.0] Cap diameter (mm)
let spigot_d = 12.0; // [8.0, 16.0] Spigot diameter (mm)
let spigot_l = 10.0; // [6.0, 16.0] Spigot length (mm)
const cap_t = 4.0;
let cap = cylinder([0, 0, 0], "Z", cap_d / 2.0, cap_t);
cap = cap.chamfer(1.0, cap.edges(">Z"));
let sp = cylinder([0, 0, -spigot_l], "Z", spigot_d / 2.0, spigot_l + 0.01) - cylinder([0, 0, -spigot_l - 1.0], "Z", spigot_d / 2.0 - 1.5, spigot_l);
let slots = fuse_all([
    box_centered(spigot_d + 2.0, 1.5, spigot_l * 1.4).translate([0, 0, -spigot_l]),
    box_centered(1.5, spigot_d + 2.0, spigot_l * 1.4).translate([0, 0, -spigot_l]),
]);
cap + (sp - slots)
