// Agarose gel comb, 10 wells: 1.5 mm thick comb, 10 teeth 5 mm wide on a 6.5 mm pitch, 8 mm deep, on a 75 x 15 mm spine with 3 mm shoulders that rest on the tray walls
let wells = 10; // [6, 15] Number of wells
let tooth_w = 5.0; // [3.0, 5.5] Tooth width (mm)
let t = 1.5; // [1.0, 2.0] Comb thickness (mm)
const pitch = 6.5;
const depth = 8.0;
let span = pitch * wells.to_float();
let spine = box_from_corners([-span / 2.0 - 5.0, 0, depth - 0.01], [span / 2.0 + 5.0, t, depth + 15.0]);
let shoulders = box_from_corners([-span / 2.0 - 5.0, -3.0, depth + 10.0], [span / 2.0 + 5.0, t + 3.0, depth + 15.0]);
let teeth = [];
for i in 0..wells { let x = -span / 2.0 + pitch * (i.to_float() + 0.5); teeth.push(box_from_corners([x - tooth_w / 2.0, 0, 0], [x + tooth_w / 2.0, t, depth])); }
spine + shoulders + fuse_all(teeth)
