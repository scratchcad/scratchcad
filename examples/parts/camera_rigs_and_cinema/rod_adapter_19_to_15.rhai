// Studio rod adapter from 19 mm to 15 mm rods: 50 x 40 x 22 mm block with a 19.1 mm bore and a 15.1 mm bore on 34 mm centres side by side along the block, each split out to the top with a 1.5 mm slot and an M4 pinch hole (4.4 mm) across it
let depth = 22.0; // [15.0, 40.0] Block depth along the rods (mm)
let big_d = 19.0; // [18.0, 20.0] Large rod diameter (mm)
let small_d = 15.0; // [12.0, 16.0] Small rod diameter (mm)
const centres = 34.0;
const height = 40.0;
const zc = 15.0;
let length = centres + big_d / 2.0 + small_d / 2.0 + 14.0;
let x0 = -length / 2.0 + big_d / 2.0 + 7.0;
let x1 = x0 + centres;
let block = box_from_corners([-length / 2.0, -depth / 2.0, 0], [length / 2.0, depth / 2.0, height]);
let block = block.fillet(3.0, block.edges("|Y"));
let cuts = [];
for p in [[x0, big_d], [x1, small_d]] {
    cuts.push(cylinder([p[0], -depth, zc], "Y", p[1] / 2.0 + 0.05, depth * 2.0));
    cuts.push(box_from_corners([p[0] - 0.75, -depth, zc], [p[0] + 0.75, depth, height + 1.0]));
    cuts.push(cylinder([p[0] - 8.0, 0, height - 6.0], "X", 2.2, 16.0));
}
block - fuse_all(cuts)
