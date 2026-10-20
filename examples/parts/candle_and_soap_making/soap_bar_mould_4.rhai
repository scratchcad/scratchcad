// Soap bar mould tray: four 80 x 55 mm cavities 25 mm deep (about 110 g bars) in a 2 x 2 grid with 8 mm walls between, a 3 mm floor and square corners
let bar_l = 80.0; // [60.0, 100.0] Bar length (mm)
let bar_w = 55.0; // [40.0, 70.0] Bar width (mm)
let depth = 25.0; // [15.0, 35.0] Bar depth (mm)
const wall = 8.0;
let w = 2.0 * bar_l + 3.0 * wall;
let d = 2.0 * bar_w + 3.0 * wall;
let tray = box_from_corners([0, 0, 0], [w, d, depth + 3.0]);
let cavities = [];
for i in 0..2 { for j in 0..2 { cavities.push(box_from_corners([wall + i.to_float() * (bar_l + wall), wall + j.to_float() * (bar_w + wall), 3.0], [wall + i.to_float() * (bar_l + wall) + bar_l, wall + j.to_float() * (bar_w + wall) + bar_w, depth + 4.0])); } }
tray - fuse_all(cavities)
