// Chew stick holder for cage bars: 60 x 15 mm clip plate 3 mm with two 2.2 mm wire hooks 20 mm apart and a 25 mm ring 10 mm tall that holds a chew stick upright
let ring = 25.0; // [15.0, 35.0] Ring inner diameter (mm)
let hook_gap = 20.0; // [10.0, 30.0] Hook spacing (mm)
const t = 3.0;
let plate = box_from_corners([-30.0, 0, 0], [30.0, t, 15.0]);
let r = cylinder([0, -ring / 2.0 - t + 0.5, 0], "Z", ring / 2.0 + t, 10.0) - cylinder([0, -ring / 2.0 - t + 0.5, -1.0], "Z", ring / 2.0, 12.0);
let hooks = [];
for x in [-hook_gap / 2.0, hook_gap / 2.0] { hooks.push(box_from_corners([x - 2.0, t - 0.01, 9.0], [x + 2.0, t + 4.0, 15.0]) + box_from_corners([x - 2.0, t + 2.6, 4.0], [x + 2.0, t + 4.0, 15.0])); }
plate + r + fuse_all(hooks)
