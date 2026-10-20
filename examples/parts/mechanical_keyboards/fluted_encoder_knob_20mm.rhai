// Rotary encoder knob: 20 mm dia 15 mm tall with 24 grip flutes, a 6 mm D-shaft bore (4.5 mm flat) 12 mm deep and a 1 mm pointer groove on top
let dia = 20.0; // [14.0, 35.0] Knob diameter (mm)
let height = 15.0; // [10.0, 25.0] Knob height (mm)
let flutes = 24; // [0, 36] Grip flutes
let k = cylinder([0, 0, 0], "Z", dia / 2.0, height);
let k = k.chamfer(1.0, k.edges(">Z"));
let cuts = [];
for i in 0..flutes { cuts.push(cylinder([dia / 2.0 + 0.3, 0, -1.0], "Z", 0.8, height - 2.0).rotate_z(i.to_float() * 360.0 / flutes.to_float())); }
let shaft = cylinder([0, 0, -1.0], "Z", 3.05, 13.0) - box_from_corners([1.5, -4.0, -2.0], [4.0, 4.0, 14.0]);
let pointer = box_from_corners([0, -0.5, height - 0.8], [dia / 2.0 + 1.0, 0.5, height + 1.0]);
if flutes > 0 { k - fuse_all(cuts) - shaft - pointer } else { k - shaft - pointer }
