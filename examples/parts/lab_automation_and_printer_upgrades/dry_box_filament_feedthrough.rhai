// Filament dry box wall feedthrough: 30 mm flange 3 mm with 2 x M3 holes on 22 mm and an O-ring groove round the spigot, 10 mm spigot through a 5 mm wall, outside boss 14 mm with an M10 tap hole (8.5 mm, 8 mm deep) for a PC4-M10 fitting, 4.2 mm PTFE bore
let flange_d = 30.0; // [28.0, 45.0] Flange diameter (mm)
let wall_t = 5.0; // [2.0, 12.0] Box wall thickness (mm)
let spigot_d = 10.0; // [8.0, 12.0] Spigot diameter (mm)
let boss_l = 10.0; // [8.0, 16.0] Fitting boss length (mm)
const flange_t = 3.0;
const tap = 8.5;
const bore = 4.2;
let rf = flange_d / 2.0;
let flange = cylinder(rf, flange_t);
let spigot = cylinder([0, 0, -wall_t - 2.0], "Z", spigot_d / 2.0, wall_t + 2.5);
let boss = cylinder([0, 0, flange_t - 0.5], "Z", 7.0, boss_l + 0.5);
let body = fuse_all([flange, spigot, boss]);
let groove = cylinder([0, 0, -1], "Z", 7.8, 1.8) - cylinder([0, 0, -2], "Z", 6.3, 4.0);
let cuts = fuse_all([
    cylinder([0, 0, -wall_t - 3.0], "Z", bore / 2.0, wall_t + flange_t + boss_l + 6.0),
    cylinder([0, 0, flange_t + boss_l - 8.0], "Z", tap / 2.0, 9.0),
    cylinder([-(rf - 4.0), 0, -1], "Z", 1.6, flange_t + 2.0),
    cylinder([rf - 4.0, 0, -1], "Z", 1.6, flange_t + 2.0)]);
body - groove - cuts
