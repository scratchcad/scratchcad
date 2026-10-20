// Laminate floor expansion spacer: 10 mm gap wedge, 40 mm wide, 45 mm tall with a 15 mm foot, stepped 8 / 10 / 12 mm faces so one spacer sets three gaps
let width = 40.0; // [25.0, 60.0] Spacer width (mm)
let height = 45.0; // [30.0, 60.0] Spacer height (mm)
let s = box_from_corners([0, 0, 0], [8.0, width, height]) + box_from_corners([7.99, 0, 0], [10.0, width, height * 0.66]) + box_from_corners([9.99, 0, 0], [12.0, width, height * 0.33]);
let foot = box_from_corners([0, 0, 0], [27.0, width, 3.0]);
s + foot - box_from_corners([14.0, width / 2.0 - 4.0, -1.0], [24.0, width / 2.0 + 4.0, 4.0])
