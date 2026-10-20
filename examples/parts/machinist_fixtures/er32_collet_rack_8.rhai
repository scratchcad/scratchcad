// ER32 collet rack: 8 conical pockets for ER32 collets (33 mm top, 8 degree cone 25 mm deep) on a 45 mm pitch in a 2 x 4 block, 185 x 95 x 35 mm with a 6 mm hanging hole
let pitch = 45.0; // [40.0, 60.0] Pocket pitch (mm)
let depth = 25.0; // [18.0, 30.0] Pocket depth (mm)
const h = 35.0;
let w = pitch * 4.0 + 5.0;
let d = pitch * 2.0 + 5.0;
let blk = box_from_corners([0, 0, 0], [w, d, h]);
let pockets = [];
for i in 0..4 { for j in 0..2 { pockets.push(cone(16.5 - depth * 0.1405, 16.5, depth + 0.01).translate([2.5 + pitch * (i.to_float() + 0.5), 2.5 + pitch * (j.to_float() + 0.5), h - depth])); } }
blk - fuse_all(pockets) - cylinder([w / 2.0, -1.0, h / 2.0], "Y", 3.0, d + 2.0)
