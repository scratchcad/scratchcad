// 1:76 scale telegraph pole: 25 ft (100 mm), tapering 2.2 to 1.6 mm, two cross arms with 4 insulators each
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
const h = 100.0;
let pole = cone(1.1, 0.8, h) + cylinder([0, 0, -6.0], "Z", 3.0, 6.01);
let arms = [];
let ins = [];
for z in [h - 4.0, h - 10.0] {
    arms.push(box_centered(18.0, 1.0, 1.0).translate([0, -1.2, z]));
    for x in [-8.0, -5.0, 5.0, 8.0] { ins.push(cylinder([x, -1.2, z + 0.49], "Z", 0.4, 1.2)); }
}
(pole + fuse_all(arms) + fuse_all(ins)).scale(s)
