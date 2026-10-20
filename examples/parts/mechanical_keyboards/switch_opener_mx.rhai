// MX switch opener: 40 x 40 mm base 4 mm thick with a 14 x 14 mm pocket and four 1.2 mm prongs that press the housing latches, plus a 10 mm finger grip
let pocket = 14.0; // [13.8, 14.2] Switch body size (mm)
let prong_h = 5.0; // [3.0, 7.0] Prong height (mm)
const t = 4.0;
let base = box_centered(40.0, 40.0, t).translate([0, 0, t / 2.0]);
let base = base.fillet(5.0, base.edges("|Z"));
let prongs = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { prongs.push(box_centered(1.2, 3.0, prong_h).translate([sx * (pocket / 2.0 + 0.6), sy * 4.0, t + prong_h / 2.0 - 0.01])); } }
let grip = box_centered(10.0, 40.0, 10.0).translate([0, 0, -5.0 + 0.01]) - box_centered(12.0, 30.0, 8.0).translate([0, 0, -6.0]);
base - box_centered(pocket, pocket, 4.0).translate([0, 0, t]) + fuse_all(prongs) + grip
