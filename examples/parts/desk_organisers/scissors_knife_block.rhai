// Desk scissors and craft knife block: 70 x 50 x 75 mm block, 3 blade slots 4 x 26 mm 60 mm deep for office scissors, 2 round 14 mm holes for craft knives, 3 mm drain holes, top edges rounded 3 mm
let width = 70.0; // [50.0, 110.0] Block width (mm)
let depth = 50.0; // [50.0, 80.0] Block depth (mm)
let height = 75.0; // [50.0, 110.0] Block height (mm)
let slots = 3; // [1, 5] Number of scissor slots
let knives = 2; // [0, 4] Number of knife holes

const slot_t = 4.0;
const slot_l = 26.0;
const knife_d = 14.0;
let hole_depth = height - 15.0;
let block = box_from_corners([0, 0, 0], [width, depth, height]);
block = block.fillet(6.0, block.edges("|Z"));
block = block.fillet(3.0, block.edges(">Z"));
let cuts = [];
let sp = (width - 10.0) / slots;
for i in 0..slots {
    let x = 5.0 + sp * (i + 0.5);
    cuts.push(box_from_corners([x - slot_t / 2.0, 6.0, height - hole_depth], [x + slot_t / 2.0, 6.0 + slot_l, height + 1.0]));
    cuts.push(cylinder([x, 6.0 + slot_l / 2.0, -1.0], "Z", 1.5, height - hole_depth + 2.0));
}
let nk = min(knives, ((width - 10.0) / (knife_d + 4.0)).to_int());
let kp = (width - 10.0) / max(nk, 1);
for i in 0..nk {
    let x = 5.0 + kp * (i + 0.5);
    cuts.push(cylinder([x, depth - 6.0 - knife_d / 2.0, height - hole_depth], "Z", knife_d / 2.0, hole_depth + 1.0));
    cuts.push(cylinder([x, depth - 6.0 - knife_d / 2.0, -1.0], "Z", 1.5, height - hole_depth + 2.0));
}
block - fuse_all(cuts)
