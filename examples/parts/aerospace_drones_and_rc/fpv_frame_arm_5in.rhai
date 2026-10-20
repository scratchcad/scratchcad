// 5 in FPV frame arm: 4 mm carbon plate, 120 mm root to motor centre, 28 mm motor pad with 16x16 and 12x12 M3 patterns, lightening slot
let len = 120.0; // [90.0, 160.0] Arm length (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let arm = fuse_all([box_from_corners([0, -7, 0], [len, 7, t]), box_from_corners([0, -10, 0], [22, 10, t]), cylinder([len, 0, 0], "Z", 14.0, t)]);
let holes = [cylinder([len, 0, -1], "Z", 3.5, t + 2.0)];
for p in [[6.0, 5.0], [6.0, -5.0], [17.0, 5.0], [17.0, -5.0], [len + 11.31, 0], [len - 11.31, 0], [len, 11.31], [len, -11.31], [len + 6.0, 6.0], [len + 6.0, -6.0], [len - 6.0, 6.0], [len - 6.0, -6.0]] {
    holes.push(cylinder([p[0], p[1], -1], "Z", 1.6, t + 2.0));
}
holes.push(box_from_corners([32, -2.5, -1], [len - 24.0, 2.5, t + 1.0]));
holes.push(cylinder([32, 0, -1], "Z", 2.5, t + 2.0));
holes.push(cylinder([len - 24.0, 0, -1], "Z", 2.5, t + 2.0));
arm - fuse_all(holes)
