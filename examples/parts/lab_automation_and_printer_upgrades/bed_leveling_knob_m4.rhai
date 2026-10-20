// Bed leveling thumb wheel for M4 screws: 30 mm knob 10 mm tall with 10 scalloped grips, M4 hex nut trap 7.1 mm across flats 3.5 mm deep, 4.3 mm through hole, 10 mm spring seat boss 3 mm on top
let knob_d = 30.0; // [20.0, 45.0] Knob diameter (mm)
let height = 10.0; // [6.0, 16.0] Knob height (mm)
let grip_count = 10; // [6, 16] Number of grip scallops
let nut_af = 7.1; // [5.6, 10.2] Nut trap across flats (mm)
let screw = 4.3; // [3.2, 6.4] Screw hole diameter (mm)
const boss_h = 3.0;
let r = knob_d / 2.0;
let knob = cylinder(r, height).chamfer(1.0, ">Z or <Z");
let sr = min(2.5, 3.14159 * r / grip_count.to_float() * 0.6);
let scallops = [];
for k in 0..grip_count {
    let a = k.to_float() * 2.0 * PI() / grip_count.to_float();
    scallops.push(cylinder([(r + sr * 0.4) * a.cos(), (r + sr * 0.4) * a.sin(), -1], "Z", sr, height + 2.0));
}
knob = knob - compound(scallops);
let boss = cylinder([0, 0, height - 0.5], "Z", max(5.0, screw / 2.0 + 2.5), boss_h + 0.5);
knob = knob + boss;
let nr = nut_af / 2.0 / (30.0 * PI() / 180.0).cos();
let pts = [];
for k in 0..6 {
    let a = (k.to_float() * 60.0) * PI() / 180.0;
    pts.push([nr * a.cos(), nr * a.sin(), -1.0]);
}
let trap = polygon(pts).to_face().extrude([0, 0, 4.5]);
knob - trap - cylinder([0, 0, -1], "Z", screw / 2.0, height + boss_h + 2.0)
