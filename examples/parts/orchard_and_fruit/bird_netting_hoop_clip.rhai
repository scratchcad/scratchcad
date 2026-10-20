// Fruit cage netting hoop clip: snaps onto a 25 mm pipe hoop, 15 mm wide C-clip 2.5 mm thick with a 20 mm mouth, and a 10 mm netting hook on the outside
let pipe = 25.0; // [16.0, 32.0] Hoop pipe diameter (mm)
let width = 15.0; // [10.0, 25.0] Clip width (mm)
const t = 2.5;
let r = pipe / 2.0;
let c = cylinder([0, 0, 0], "Y", r + t, width) - cylinder([0, -1.0, 0], "Y", r, width + 2.0) - box_from_corners([-r * 0.8, -1.0, -r - t - 1.0], [r * 0.8, width + 1.0, -r * 0.6]);
let hook = box_from_corners([-2.0, 0, r + t - 0.5], [2.0, width, r + t + 10.0]) + box_from_corners([-2.0, 0, r + t + 7.0], [8.0, width, r + t + 10.0]) + box_from_corners([5.0, 0, r + t + 4.0], [8.0, width, r + t + 10.0]);
c + hook
