// Toilet cubicle partition pedestal foot: 60 mm round floor plate 5 mm thick with two 5 mm screw holes, a 25 mm leg 100 mm tall with a 1 mm chamfer at the top, and a U shoe 30 mm tall on top for a 13 mm compact laminate panel (13.4 mm slot) with a 5 mm fixing hole through the cheeks
let leg_h = 100.0; // [60.0, 180.0] Leg height (mm)
let leg_d = 25.0; // [20.0, 40.0] Leg diameter (mm)
let panel_t = 13.0; // [10.0, 20.0] Panel thickness (mm)
let base_d = 60.0; // [45.0, 90.0] Floor plate diameter (mm)
const base_t = 5.0;
const shoe_h = 30.0;
const cheek = 4.0;
let rb = max(base_d / 2.0, leg_d / 2.0 + 10.0);
let base = cylinder([0, 0, 0], "Z", rb, base_t);
let base = base.chamfer(1.0, base.edges(">Z"));
let leg = cylinder([0, 0, base_t - 0.5], "Z", leg_d / 2.0, leg_h - base_t + 0.5);
let slot = panel_t + 0.4;
let sw = slot + 2.0 * cheek;
let shoe = box_centered(max(leg_d + 10.0, 40.0), sw, shoe_h).translate([0, 0, leg_h - 0.5 + shoe_h / 2.0]);
let body = fuse_all([base, leg, shoe]);
let hx = (rb + leg_d / 2.0) / 2.0;
let cuts = [
    box_centered(max(leg_d + 10.0, 40.0) + 2.0, slot, shoe_h).translate([0, 0, leg_h + 5.0 + shoe_h / 2.0]),
    cylinder([0, -sw, leg_h + 5.0 + shoe_h / 2.0], "Y", 2.5, 2.0 * sw),
    cylinder([hx, 0, -1.0], "Z", 2.5, base_t + 2.0),
    cylinder([-hx, 0, -1.0], "Z", 2.5, base_t + 2.0)
];
body - fuse_all(cuts)
