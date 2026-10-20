// Safety wire tab washer for 1/4 in bolts: 6.6 mm hole, 14 mm washer 1 mm with 8 mm tab and 1.2 mm wire hole
let bolt = 6.6; // [4.0, 12.0] Bolt hole (mm)
let od = 14.0; // [10.0, 24.0] Washer OD (mm)
let t = 1.0; // [0.6, 2.0] Thickness (mm)
let w = cylinder(od / 2.0, t) + box_from_corners([0, -3.0, 0], [od / 2.0 + 8.0, 3.0, t]) + cylinder([od / 2.0 + 8.0, 0, 0], "Z", 3.0, t);
w - cylinder([0, 0, -1], "Z", bolt / 2.0, t + 2.0) - cylinder([od / 2.0 + 8.0, 0, -1], "Z", 0.6, t + 2.0)
