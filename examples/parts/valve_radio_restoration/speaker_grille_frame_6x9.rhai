// Radio speaker grille cloth frame: 180 x 130 mm frame 6 mm thick with a 150 x 100 mm opening and a 15 mm border, cloth tuck groove 1.5 mm and four 3.5 mm screw holes
let width = 180.0; // [120.0, 260.0] Frame width (mm)
let height = 130.0; // [90.0, 200.0] Frame height (mm)
const t = 6.0;
let f = box_centered(width, height, t).translate([0, 0, t / 2.0]) - box_centered(width - 30.0, height - 30.0, t + 2.0).translate([0, 0, t / 2.0]);
let groove = box_centered(width - 18.0, height - 18.0, 2.0).translate([0, 0, 1.0 - 0.01]) - box_centered(width - 21.0, height - 21.0, 4.0).translate([0, 0, 1.0]);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (width / 2.0 - 6.0), sy * (height / 2.0 - 6.0), -1.0], "Z", 1.75, t + 2.0)); } }
f - groove - fuse_all(holes)
