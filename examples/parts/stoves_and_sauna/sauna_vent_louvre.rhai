// Sauna vent louvre: 200 x 100 mm grille, 15 mm frame depth, 8 slats 3 mm thick tilted 45 degrees, with a 10 mm flange and 4 screw holes
let width = 200.0; // [120.0, 300.0] Opening width (mm)
let height = 100.0; // [80.0, 200.0] Opening height (mm)
let slats = 8; // [4, 14] Number of slats
const depth = 15.0;
let frame = box_from_corners([-width / 2.0, -height / 2.0, 0], [width / 2.0, height / 2.0, depth]) - box_from_corners([-width / 2.0 + 3.0, -height / 2.0 + 3.0, -1.0], [width / 2.0 - 3.0, height / 2.0 - 3.0, depth + 1.0]);
let flange = box_from_corners([-width / 2.0 - 10.0, -height / 2.0 - 10.0, 0], [width / 2.0 + 10.0, height / 2.0 + 10.0, 3.0]) - box_from_corners([-width / 2.0 + 1.0, -height / 2.0 + 1.0, -1.0], [width / 2.0 - 1.0, height / 2.0 - 1.0, 5.0]);
let p = (height - 6.0) / slats.to_float();
let s = [];
for i in 0..slats { s.push(box_centered(width - 5.0, 3.0, depth * 1.2).rotate_x(45.0).translate([0, -height / 2.0 + 3.0 + p * (i.to_float() + 0.5), depth / 2.0])); }
let slat = fuse_all(s) & box_from_corners([-width / 2.0 + 2.0, -height / 2.0 + 2.0, 0], [width / 2.0 - 2.0, height / 2.0 - 2.0, depth]);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (width / 2.0 + 5.0), sy * (height / 2.0 + 5.0), -1.0], "Z", 2.0, 5.0)); } }
frame + flange + slat - fuse_all(holes)
