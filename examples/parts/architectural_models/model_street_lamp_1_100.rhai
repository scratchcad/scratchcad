// 1:100 model street lamp: 6 m column as 60 mm, 1 mm square post on a 3 mm base, with a 12 mm outreach arm and 3 x 1.5 mm lantern head
let height = 60.0; // [30.0, 120.0] Column height (mm)
let arm = 12.0; // [6.0, 20.0] Outreach arm (mm)
let base = box_centered(3.0, 3.0, 1.0).translate([0, 0, 0.5]);
let post = box_centered(1.0, 1.0, height).translate([0, 0, height / 2.0 + 0.99]);
let a = box_from_corners([-0.5, -0.5, height], [arm, 0.5, height + 0.8]);
let head = box_from_corners([arm - 3.0, -0.75, height - 0.8], [arm, 0.75, height + 0.81]);
base + post + a + head
