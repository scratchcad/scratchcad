// Portable hangboard edge block: 200 mm wide, 40 mm deep, 80 mm tall with three edges of 20, 15 and 10 mm depth with 6 mm radiused lips, a 10 mm rope hole and two 8 mm holes for the loop cord
let width = 200.0; // [150.0, 300.0] Block width (mm)
let lip_r = 6.0; // [3.0, 7.0] Edge radius (mm)
const height = 80.0;
let b = box_from_corners([0, -width / 2.0, 0], [40.0, width / 2.0, height]);
let steps = box_from_corners([20.0, -width / 2.0 - 1.0, 65.0], [41.0, width / 2.0 + 1.0, height + 1.0]) + box_from_corners([25.0, -width / 2.0 - 1.0, 40.0], [41.0, width / 2.0 + 1.0, 50.0]) + box_from_corners([30.0, -width / 2.0 - 1.0, 15.0], [41.0, width / 2.0 + 1.0, 25.0]);
let b = b - steps;
let b = b.fillet(lip_r, b.edges("|Y and >X"));
b - cylinder([10.0, 0, -1.0], "Z", 5.0, height + 2.0) - cylinder([10.0, -width / 2.0 + 15.0, -1.0], "Z", 4.0, height + 2.0) - cylinder([10.0, width / 2.0 - 15.0, -1.0], "Z", 4.0, height + 2.0)
