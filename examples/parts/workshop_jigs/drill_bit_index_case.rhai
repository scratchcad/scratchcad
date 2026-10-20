// Drill bit index block, 1/16 to 1/4 in by 64ths: 13 holes 1.6 to 6.4 mm (+0.2 mm), 20 mm deep, in a 160 x 40 x 25 mm block with a stepped label ledge
let length = 160.0; // [120.0, 220.0] Block length (mm)
let width = 40.0; // [30.0, 60.0] Block width (mm)
let height = 25.0; // [18.0, 40.0] Block height (mm)
let depth = 20.0; // [10.0, 35.0] Hole depth (mm)
let blk = box_from_corners([0, 0, 0], [length, width, height]);
let b = blk.fillet(3.0, blk.edges("|Z"));
let ledge = box_from_corners([-1, -1, height - 4.0], [length + 1.0, 10.0, height + 1.0]);
let pitch = (length - 20.0) / 12.0;
let holes = [];
for i in 0..13 {
    let d = (4.0 + i.to_float()) / 64.0 * 25.4 + 0.2;
    holes.push(cylinder([10.0 + i.to_float() * pitch, width * 0.6, height - min(depth, height - 2.0)], "Z", d / 2.0, depth + 1.0));
}
b - ledge - compound(holes)
