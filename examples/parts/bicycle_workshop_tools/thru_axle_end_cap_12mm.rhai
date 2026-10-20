// Thru-axle trainer end cap: 12 mm spigot 9 mm long that fits a 12 mm thru-axle dropout, 22 mm flange 3 mm thick, 5.3 mm bore for a quick-release skewer, 0.8 mm chamfers
let spigot_d = 12.0; // [10.0, 15.0] Spigot diameter (mm)
let spigot_len = 9.0; // [5.0, 14.0] Spigot length (mm)
let flange_d = 22.0; // [18.0, 30.0] Flange diameter (mm)
let flange_t = 3.0; // [2.0, 5.0] Flange thickness (mm)
const bore = 5.3;
let flange = cylinder(flange_d / 2.0, flange_t);
let flange = flange.chamfer(0.8, flange.edges("<Z"));
let spigot = cylinder([0, 0, flange_t - 0.5], "Z", spigot_d / 2.0, spigot_len + 0.5);
let spigot = spigot.chamfer(0.8, spigot.edges(">Z"));
(flange + spigot) - cylinder([0, 0, -1.0], "Z", bore / 2.0, flange_t + spigot_len + 2.0)
