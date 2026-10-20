// Swivel jaw pad for a spring clamp: 20 mm pad 3 mm thick with grip grooves, 10 mm boss with a 6.2 mm snap-on ball socket
let pad_d = 20.0; // [14.0, 30.0] Pad diameter (mm)
let pad_t = 3.0; // [2.0, 5.0] Pad thickness (mm)
let ball_d = 6.2; // [4.0, 8.0] Ball socket diameter (mm)
let boss_h = 6.0; // [4.0, 9.0] Boss height (mm)
let br = ball_d / 2.0 + 1.9;
let pad = cylinder(pad_d / 2.0, pad_t);
let p = pad.chamfer(0.6, pad.edges(">Z"));
let boss = cylinder([0, 0, pad_t - 0.5], "Z", br, boss_h + 0.5);
let zc = pad_t + boss_h - ball_d * 0.32;
let grooves = [];
for i in 0..4 { grooves.push(box_from_corners([-pad_d, -pad_d / 2.0 + (i.to_float() + 1.0) * pad_d / 5.0 - 0.4, -1], [pad_d, -pad_d / 2.0 + (i.to_float() + 1.0) * pad_d / 5.0 + 0.4, 0.6])); }
p + boss - sphere([0, 0, zc], ball_d / 2.0) - compound(grooves)
