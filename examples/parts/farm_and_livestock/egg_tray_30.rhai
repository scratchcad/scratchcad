// 30-cell egg tray: 300 x 300 x 45 mm, 6 x 5 cells at 50 mm, 42 mm cups, 1.5 mm wall
let pitch = 50.0; // [40.0, 60.0] Cell pitch (mm)
let cup_d = 42.0; // [35.0, 50.0] Cup diameter (mm)
let depth = 35.0; // [25.0, 45.0] Cup depth (mm)
let wall = 1.5; // [1.0, 3.0] Wall (mm)
const cols = 6;
const rows = 5;
let w = cols.to_float() * pitch;
let l = rows.to_float() * pitch;
let slab = box_from_corners([0, 0, depth - wall], [w, l, depth]);
let cups = [];
let cuts = [];
for i in 0..cols { for j in 0..rows {
    let x = (i.to_float() + 0.5) * pitch;
    let y = (j.to_float() + 0.5) * pitch;
    cups.push(sphere([x, y, depth], cup_d / 2.0 + wall) & box_from_corners([x - pitch, y - pitch, depth - cup_d / 2.0 - wall], [x + pitch, y + pitch, depth]));
    cuts.push(sphere([x, y, depth], cup_d / 2.0));
} }
(fuse_all(cups) + slab) - compound(cuts)
