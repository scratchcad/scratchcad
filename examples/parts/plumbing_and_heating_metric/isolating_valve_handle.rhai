// 15 mm isolating valve quarter-turn handle: 30 mm lever 8 mm wide 3 mm thick, 10 mm boss 9 mm tall, 5 mm double-D spindle bore (3.6 mm flats) 7 mm deep, 2.2 mm retaining screw hole
let lever = 30.0; // [20.0, 50.0] Lever length (mm)
let lever_w = 8.0; // [6.0, 12.0] Lever width (mm)
let lever_t = 3.0; // [2.0, 5.0] Lever thickness (mm)
let boss_d = 10.0; // [8.0, 14.0] Boss diameter (mm)
let boss_h = 9.0; // [6.0, 14.0] Boss height (mm)
let spindle = 5.0; // [4.0, 6.5] Spindle diameter (mm)
let flats = 3.6; // [2.5, 5.0] Spindle across flats (mm)
let bd = max(boss_d, spindle + 3.0);
let boss = cylinder(bd / 2.0, boss_h);
let arm = box_from_corners([0, -lever_w / 2.0, boss_h - lever_t], [lever, lever_w / 2.0, boss_h]);
let arm = arm.fillet(lever_w * 0.45, arm.edges("|Z and >X"));
let grips = [];
for k in 0..4 {
    grips.push(box_centered(1.0, lever_w + 2.0, 1.2).translate([lever - 4.0 - k.to_float() * 2.5, 0, boss_h]));
}
let drive = cylinder([0, 0, -1], "Z", spindle / 2.0, boss_h - 1.0) & box_centered(min(flats, spindle - 0.2), spindle + 2.0, boss_h * 3.0);
boss + arm - compound(grips) - drive - cylinder([0, 0, boss_h - 3.0], "Z", 1.1, 5.0)
