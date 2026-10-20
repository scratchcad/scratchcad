// Patch cord hanger comb: 200 mm wall comb 30 mm deep, 6 mm thick with 12 fingers 8 mm wide leaving cord slots of about 8 mm, and two 5 mm hanging holes
let length = 200.0; // [120.0, 300.0] Comb length (mm)
let fingers = 12; // [6, 20] Number of fingers
const t = 6.0;
let back = box_from_corners([0, 0, 0], [length, t, 40.0]);
let f = [];
let p = length / fingers.to_float();
for i in 0..fingers { f.push(box_from_corners([p * i.to_float() + (p - 8.0) / 2.0, t - 0.01, 0], [p * i.to_float() + (p + 8.0) / 2.0, t + 30.0, t])); }
back + fuse_all(f) - cylinder([length * 0.2, -1.0, 30.0], "Y", 2.5, t + 2.0) - cylinder([length * 0.8, -1.0, 30.0], "Y", 2.5, t + 2.0)
