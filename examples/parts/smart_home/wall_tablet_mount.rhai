// Wall tablet mount: 250 x 170 mm frame for a 245 x 165 x 8 mm tablet, 3 mm lips, cable notch 20 mm, 4 screw holes
let tw = 245.0; // [180.0, 300.0] Tablet width (mm)
let th = 165.0; // [120.0, 220.0] Tablet height (mm)
let tt = 8.0; // [6.0, 12.0] Tablet thickness (mm)
let wall = 3.0; // [2.0, 4.0] Wall (mm)
let back = box_centered(tw + 2.0 * wall, th + 2.0 * wall, wall).translate([0, 0, wall / 2.0]);
let rim = box_centered(tw + 2.0 * wall, th + 2.0 * wall, tt + wall).translate([0, 0, (tt + wall) / 2.0 + wall - 0.01]) - box_centered(tw, th, tt + wall + 2.0).translate([0, 0, wall + (tt + wall) / 2.0]);
let lips = box_centered(tw + 2.0 * wall, th + 2.0 * wall, wall).translate([0, 0, tt + 1.5 * wall + wall - 0.01]) - box_centered(tw - 6.0, th - 6.0, wall * 3.0).translate([0, 0, tt + 2.0 * wall]);
let frame = back + rim + lips;
let window = box_centered(tw - 40.0, th - 40.0, wall * 3.0);
let w = window.fillet(10.0, window.edges("|Z"));
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (tw / 2.0 - 10.0), sy * (th / 2.0 - 10.0), -1], "Z", 2.2, wall + 2.0)); } }
frame - w - compound(holes) - box_centered(20.0, wall * 4.0, tt + 3.0 * wall).translate([0, -th / 2.0 - wall / 2.0, (tt + 3.0 * wall) / 2.0 + wall])
