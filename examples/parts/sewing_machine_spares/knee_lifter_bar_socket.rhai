// Knee lifter bar socket: 30 x 30 x 3 mm mounting flange with two 4.5 mm screw holes on the diagonal, 18 mm square boss 20 mm long with a 7 mm D-shaped bore (5.8 mm across the flat) 18 mm deep for the knee lifter bar
let flange = 30.0; // [24.0, 40.0] Flange size (mm)
let boss = 18.0; // [14.0, 24.0] Boss size (mm)
let boss_len = 20.0; // [12.0, 30.0] Boss length (mm)
let bar_d = 7.0; // [6.0, 9.0] Bar diameter (mm)
const flange_t = 3.0;
let plate = box_centered(flange, flange, flange_t).translate([0, 0, flange_t / 2.0]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let b = box_centered(boss, boss, boss_len).translate([0, 0, flange_t + boss_len / 2.0 - 0.5]);
let b = b.chamfer(0.8, b.edges(">Z"));
let body = plate + b;
let top = flange_t + boss_len - 0.5;
let depth = min(18.0, boss_len);
let d_bore = cylinder([0, 0, top - depth], "Z", bar_d / 2.0, depth + 1.0) - box_from_corners([bar_d / 2.0 - (bar_d - bar_d * 0.83), -bar_d, top - depth - 1.0], [bar_d, bar_d, top + 2.0]);
let hole_off = flange / 2.0 - 4.0;
body - fuse_all([
    d_bore,
    cylinder([hole_off, hole_off, -1.0], "Z", 2.25, flange_t + 2.0),
    cylinder([-hole_off, -hole_off, -1.0], "Z", 2.25, flange_t + 2.0),
])
