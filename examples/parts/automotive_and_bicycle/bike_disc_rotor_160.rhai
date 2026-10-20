// 160 mm 6-bolt MTB disc rotor: 1.8 mm steel, 44 mm bolt circle, 17 mm braking track with 72 drilled holes, six skewed arms
let dia = 160.0; // [140.0, 203.0] Rotor diameter (mm)
let t = 1.8; // [1.5, 2.3] Thickness (mm)
let ro = dia / 2.0;
let track = cylinder(ro, t) - cylinder([0, 0, -1], "Z", ro - 17.0, t + 2.0);
let hub = cylinder(29.0, t) - cylinder([0, 0, -1], "Z", 17.0, t + 2.0);
let parts = [track, hub];
let arm_len = ro - 14.0 - 26.0;
for i in 0..6 { parts.push(box_centered(arm_len, 7.0, t).rotate("Z", 12.0).translate([26.0 + arm_len / 2.0, 0, t / 2.0]).rotate("Z", i.to_float() * 60.0)); }
let rotor = fuse_all(parts);
let holes = [];
for k in 0..24 { for j in 0..3 { holes.push(cylinder([ro - 14.0 + j.to_float() * 4.5, 0, -1], "Z", 1.8, t + 2.0).rotate("Z", k.to_float() * 15.0 + j.to_float() * 5.0)); } }
for i in 0..6 { holes.push(cylinder([22.0, 0, -1], "Z", 2.6, t + 2.0).rotate("Z", 30.0 + i.to_float() * 60.0)); }
rotor - fuse_all(holes)
