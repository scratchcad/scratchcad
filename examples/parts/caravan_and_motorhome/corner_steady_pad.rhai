// Caravan corner steady foot pad: 150 x 150 x 12 mm pad with 6 mm corner radii, a 40 x 30 mm foot cradle 20 mm deep with 4 mm walls, and 8 grip ribs 2 mm high underneath
let size = 150.0; // [100.0, 200.0] Pad size (mm)
let cradle_w = 40.0; // [30.0, 60.0] Steady foot width (mm)
const t = 12.0;
const wall = 4.0;
let pad = box_centered(size, size, t).translate([0, 0, t / 2.0]);
let pad = pad.fillet(6.0, pad.edges("|Z"));
let cradle = box_centered(cradle_w + 2.0 * wall, 30.0 + 2.0 * wall, 20.0).translate([0, 0, t + 10.0 - 0.01]) - box_centered(cradle_w, 30.0, 22.0).translate([0, 0, t + 12.0]);
let ribs = [];
for i in 0..8 { ribs.push(box_centered(size - 20.0, 4.0, 2.01).translate([0, -size / 2.0 + 15.0 + i.to_float() * (size - 30.0) / 7.0, -1.0 + 0.01])); }
pad + cradle + fuse_all(ribs)
