// Robot vacuum side brush hub: 25 mm hub 6 mm, 3 bristle-tuft arms 40 mm with 3 mm tuft holes, 5 mm D-shaft socket
let arm = 40.0; // [25.0, 60.0] Arm length (mm)
let hub_d = 25.0; // [18.0, 35.0] Hub diameter (mm)
let hub = cylinder(hub_d / 2.0, 6.0);
let arms = [];
for k in 0..3 { arms.push(box_from_corners([0, -3.0, 0], [arm, 3.0, 4.0]).rotate_z(k.to_float() * 120.0)); }
let tufts = [];
for k in 0..3 { for j in 0..2 { tufts.push(cylinder([arm - 4.0 - j.to_float() * 7.0, 0, -1], "Z", 1.5, 6.0).rotate_z(k.to_float() * 120.0)); } }
let d = cylinder([0, 0, -1], "Z", 2.5, 6.0) - box_from_corners([1.5, -3, -2], [3, 3, 6]);
hub + fuse_all(arms) - compound(tufts) - d
