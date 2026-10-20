// 1:76 GWR lower-quadrant semaphore signal: 25 ft post (100 mm), 2 mm square, arm 15 x 2.5 mm, ladder, finial
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
let post = box_centered(2.0, 2.0, 100.0).translate([0, 0, 50.0]);
let finial = cone(1.4, 0.2, 3.0).translate([0, 0, 99.99]) + cylinder([0, 0, 99.0], "Z", 1.4, 1.0);
let arm = box_from_corners([1.0, -1.4, 88.0], [16.0, -1.0, 90.5]).rotate([1.0, -1.2, 89.25], "Y", -10.0) + box_from_corners([-0.5, -1.5, 88.0], [1.01, -0.99, 90.5]);
let lamp = box_from_corners([-1.0, 1.0, 82.0], [1.0, 3.0, 85.0]);
let ladder = box_from_corners([-1.5, -6.0, 0], [-1.1, -5.6, 86.0]) + box_from_corners([1.1, -6.0, 0], [1.5, -5.6, 86.0]);
let rungs = [];
for k in 0..20 { rungs.push(box_from_corners([-1.5, -6.0, 4.0 + k.to_float() * 4.0], [1.5, -5.7, 4.3 + k.to_float() * 4.0])); }
let stays = box_from_corners([-0.3, -5.8, 80.0], [0.3, 0.01, 80.5]);
let base = box_centered(8.0, 12.0, 1.0).translate([0, -3.0, 0.5]);
(post + finial + arm + lamp + ladder + fuse_all(rungs) + stays + base).scale(s)
