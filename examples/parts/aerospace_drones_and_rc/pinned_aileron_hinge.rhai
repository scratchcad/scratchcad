// Pinned aileron hinge: two 20 x 11 x 0.8 mm leaves, three 2.4 mm knuckles, 0.8 mm pin fixed in the outer knuckles
let len = 20.0; // [12.0, 40.0] Hinge length (mm)
let seg = (len - 0.5) / 3.0;
let a = fuse_all([
    box_from_corners([0, 0.8, -0.4], [len, 12.0, 0.4]),
    cylinder([0, 0, 0], "X", 1.2, seg),
    cylinder([len - seg, 0, 0], "X", 1.2, seg),
    cylinder([0, 0, 0], "X", 0.4, len)
]);
let b = box_from_corners([seg + 0.25, -12.0, -0.4], [len - seg - 0.25, -0.8, 0.4]) + box_from_corners([0, -12.0, -0.4], [len, -6.0, 0.4]) + cylinder([seg + 0.25, 0, 0], "X", 1.2, seg - 0.5);
let b2 = b - cylinder([-1, 0, 0], "X", 0.5, len + 2.0) - box_from_corners([-1, -1.2, -2], [seg + 0.25, 1.2, 2]) - box_from_corners([len - seg - 0.25, -1.2, -2], [len + 1.0, 1.2, 2]);
compound([a, b2])
