// 1:76 Euro pallet: 1200 x 800 x 144 mm real (15.8 x 10.5 x 1.9 mm), 5 top boards, 9 blocks, 3 bottom boards
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let k = 1.0 / scale_;
let tops = [];
for b in [[0.0, 145.0], [227.5, 100.0], [350.0, 100.0], [472.5, 100.0], [655.0, 145.0]] { tops.push(box_from_corners([0, b[0], 122.0], [1200.0, b[0] + b[1], 144.0])); }
let blocks = [];
for x in [0.0, 527.5, 1055.0] { for y in [0.0, 345.0, 655.0] { blocks.push(box_from_corners([x, y, 22.0], [x + 145.0, y + 145.0, 100.0])); } }
let stringers = [];
for x in [0.0, 527.5, 1055.0] { stringers.push(box_from_corners([x, 0, 100.0], [x + 145.0, 800.0, 122.0])); }
let bottoms = [];
for y in [0.0, 345.0, 655.0] { bottoms.push(box_from_corners([0, y, 0], [1200.0, y + 145.0, 22.0])); }
fuse_all(tops + blocks + stringers + bottoms).scale(k)
