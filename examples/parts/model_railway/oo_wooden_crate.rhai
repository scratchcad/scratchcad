// 1:76 wooden packing crate: 3 x 2 x 2 ft (12 x 8 x 8 mm), planked sides with corner battens
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
let crate_ = box(12.0, 8.0, 8.0);
let grooves = [];
for z in [2.0, 4.0, 6.0] { grooves.push(box_from_corners([-1, -1, z - 0.08], [13.0, 9.0, z + 0.08]) - box_from_corners([0.15, 0.15, z - 1.0], [11.85, 7.85, z + 1.0])); }
let battens = [];
for x in [0.0, 11.4] { for y in [0.0, 7.4] { battens.push(box_from_corners([x - 0.1, y - 0.1, 0], [x + 0.7, y + 0.7, 8.0])); } }
(crate_ - compound(grooves) + fuse_all(battens)).scale(s)
