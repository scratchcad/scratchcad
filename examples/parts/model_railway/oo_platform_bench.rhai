// OO scale station bench: 1:76, 6 ft long (24 mm), 3 slats, cast iron ends
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
const length = 24.0;
let slats = [];
for k in 0..2 { slats.push(box_from_corners([0, k.to_float() * 1.6, 5.6], [length, k.to_float() * 1.6 + 1.2, 6.0])); }
let back = box_from_corners([0, 3.4, 6.5], [length, 3.7, 9.5]).rotate([0, 3.4, 6.0], "X", -12.0);
let e = [];
for x in [1.5, length - 2.0] { e.push(box_from_corners([x, 0, 0], [x + 0.5, 0.6, 5.61]) + box_from_corners([x, 3.0, 0], [x + 0.5, 3.6, 9.6]) + box_from_corners([x, 0, 5.0], [x + 0.5, 3.6, 5.61])); }
(fuse_all(slats) + back + fuse_all(e)).scale(s)
