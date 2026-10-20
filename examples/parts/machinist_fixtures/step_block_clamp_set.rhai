// Milling step block: 6 steps of 10 mm rise and 12.5 mm tread, 25 mm wide, with a 1 mm relief groove at each step root for the clamp heel
let steps = 6; // [3, 8] Number of steps
let rise = 10.0; // [6.0, 15.0] Step rise (mm)
const tread = 12.5;
const w = 25.0;
let parts = [];
for i in 0..steps { parts.push(box_from_corners([i.to_float() * tread, 0, 0], [steps.to_float() * tread, w, rise * (i.to_float() + 1.0)])); }
let blk = fuse_all(parts);
let grooves = [];
for i in 1..steps { grooves.push(cylinder([i.to_float() * tread, -1.0, rise * i.to_float()], "Y", 0.8, w + 2.0)); }
blk - fuse_all(grooves)
