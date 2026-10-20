// Garage opener door bracket: 100 x 50 mm base plate 3 mm with four 7 mm holes, two 40 mm tall ears 25 mm apart with 9 mm clevis pin holes 30 mm up
let ear_gap = 25.0; // [15.0, 35.0] Ear spacing (mm)
let ear_h = 40.0; // [25.0, 60.0] Ear height (mm)
const t = 3.0;
let base = box_centered(100.0, 50.0, t).translate([0, 0, t / 2.0]);
let ears = box_from_corners([-ear_gap / 2.0 - t, -15.0, t - 0.01], [-ear_gap / 2.0, 15.0, ear_h]) + box_from_corners([ear_gap / 2.0, -15.0, t - 0.01], [ear_gap / 2.0 + t, 15.0, ear_h]);
let holes = [cylinder([-ear_gap, 0, ear_h - 10.0], "X", 4.5, 2.0 * ear_gap)];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 40.0, sy * 17.0, -1.0], "Z", 3.5, t + 2.0)); } }
base + ears - fuse_all(holes)
