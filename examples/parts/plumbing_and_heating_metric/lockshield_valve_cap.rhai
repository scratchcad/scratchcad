// Radiator lockshield valve cap: 28 mm cup 22 mm tall, 2 mm wall, 20 grip flutes, 8 mm square spindle socket 10 mm deep in a 14 mm inner boss, 3.5 mm retaining screw hole
let diameter = 28.0; // [22.0, 36.0] Cap diameter (mm)
let height = 22.0; // [16.0, 30.0] Cap height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let flutes = 20; // [8, 32] Number of grip flutes
let spindle = 8.0; // [6.0, 10.0] Spindle socket across flats (mm)
const top_t = 3.0;
let r = diameter / 2.0;
let cap = cylinder(r, height);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let cap = cap - cylinder([0, 0, -1], "Z", r - wall, height - top_t + 1.0);
let boss_r = min(spindle * 0.75 + 1.5, r - wall - 1.0);
let boss = cylinder([0, 0, height - top_t - 10.0], "Z", boss_r, 10.5);
let body = cap + boss;
let cuts = [];
for k in 0..flutes {
    let a = k.to_float() * 360.0 / flutes.to_float();
    cuts.push(cylinder([r + 0.3, 0, -1], "Z", 0.9, height - 3.0).rotate_z(a));
}
let socket = box_centered(spindle, spindle, 20.0).translate([0, 0, height - top_t - 10.0]);
body - fuse_all(cuts) - socket - cylinder([0, 0, height - top_t - 1.0], "Z", 1.75, top_t + 2.0)
