// Aluminium mounting hub for a 6 mm D-shaft: 22 mm flange 3 mm thick with four M3 holes on a 16 mm circle and an M3 centre tap, 12 mm hub 10 mm long, M3 set screw on the flat
let shaft_d = 6.0; // [3.0, 8.0] Shaft diameter (mm)
let flange_d = 22.0; // [16.0, 40.0] Flange diameter (mm)
let hub_d = 12.0; // [9.0, 18.0] Hub diameter (mm)
let hub_len = 10.0; // [6.0, 20.0] Hub length (mm)
let bolt_circle = 16.0; // [10.0, 34.0] Bolt circle diameter (mm)
const flange_t = 3.0;
let hd = max(hub_d, shaft_d + 5.0);
let fd = max(flange_d, hd + 6.0);
let bc = min(max(bolt_circle, hd + 3.5), fd - 4.0);
let h = cylinder(fd / 2.0, flange_t).chamfer(0.5, ">Z or <Z") + cylinder([0, 0, flange_t - 0.01], "Z", hd / 2.0, hub_len).chamfer(0.5, ">Z");
h -= cylinder([0, 0, -1], "Z", shaft_d / 2.0, hub_len + flange_t + 2.0) - box_from_corners([shaft_d / 2.0 - 0.5, -shaft_d, flange_t + 0.5], [shaft_d, shaft_d, hub_len + flange_t + 2.0]);
for i in 0..4 { h -= cylinder([bc / 2.0, 0, -1], "Z", 1.6, flange_t + 2.0).rotate_z(i.to_float() * 90.0 + 45.0); }
h - cylinder([0, 0, flange_t + hub_len * 0.55], "X", 1.25, hd)
