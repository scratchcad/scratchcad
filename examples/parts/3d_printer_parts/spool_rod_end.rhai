// Spool rod end cap: 8 mm rod, 30 mm stop flange, 10 mm boss with an M3 grub screw
let rod = 8.0; // [6.0, 16.0] Rod diameter (mm)
let flange_d = 30.0; // [15.0, 50.0] Flange diameter (mm)
let flange_t = 3.0; // [2.0, 5.0] Flange thickness (mm)
let boss_l = 10.0; // [6.0, 20.0] Boss length (mm)
let cap = cylinder(flange_d / 2.0, flange_t).fillet(1.0, ">Z") + cylinder([0, 0, flange_t - 0.01], "Z", rod / 2.0 + 3.0, boss_l);
cap - cylinder([0, 0, 1.0], "Z", rod / 2.0, flange_t + boss_l) - cylinder([0, 0, flange_t + boss_l / 2.0], "X", 1.4, flange_d)
