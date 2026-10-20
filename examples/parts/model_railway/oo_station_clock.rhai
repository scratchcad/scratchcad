// 1:76 double-sided platform clock: 8 mm dial in a 9.5 mm drum case, bracket arm 8 mm with scroll
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
let case_ = cylinder([0, -1.2, 0], "Y", 4.75, 2.4);
let dials = cylinder([0, -1.5, 0], "Y", 4.0, 0.31) + cylinder([0, 1.19, 0], "Y", 4.0, 0.31);
let marks = [];
for k in 0..12 { marks.push(box_centered(0.2, 4.0, 0.8).translate([0, 0, 3.4]).rotate_y(k.to_float() * 30.0)); }
let finial = sphere([0, 0, 5.2], 0.7);
let arm = box_from_corners([-0.4, -0.4, 4.6], [0.4, 0.4, 7.0]) + box_from_corners([-0.4, -0.4, 6.5], [8.0, 0.4, 7.3]);
(case_ + dials - compound(marks) + finial + arm).scale(s)
