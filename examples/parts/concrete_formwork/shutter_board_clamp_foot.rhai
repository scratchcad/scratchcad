// Concrete shuttering kicker clamp foot: 100 x 50 mm base 6 mm with two 12 mm ground pin holes and a 50 mm upright 6 mm thick with a 20 x 8 mm wedge slot
let width = 50.0; // [35.0, 80.0] Clamp width (mm)
let upright = 50.0; // [35.0, 80.0] Upright height (mm)
const t = 6.0;
let base = box_from_corners([0, 0, 0], [100.0, width, t]);
let up = box_from_corners([0, 0, 0], [t, width, upright]);
let gusset = face(polygon([[t - 0.01, width / 2.0 - 3.0, t - 0.01], [40.0, width / 2.0 - 3.0, t - 0.01], [t - 0.01, width / 2.0 - 3.0, upright * 0.8]])).extrude([0, 6.0, 0]);
base + up + gusset - cylinder([60.0, width / 2.0 - 12.0, -1.0], "Z", 6.0, t + 2.0) - cylinder([85.0, width / 2.0 + 12.0, -1.0], "Z", 6.0, t + 2.0) - box_from_corners([-1.0, width / 2.0 - 10.0, upright - 18.0], [t + 1.0, width / 2.0 + 10.0, upright - 10.0])
