// Kitchen compost caddy lid: 200 x 140 mm rounded lid 10 mm deep with 2 mm walls, a 60 mm filter recess with 19 vent holes 4 mm and a 50 x 10 mm flip handle bar
let length = 200.0; // [160.0, 260.0] Lid length (mm)
let width = 140.0; // [110.0, 180.0] Lid width (mm)
const wall = 2.0;
let l = box_centered(length, width, 10.0).translate([0, 0, 5.0]);
let l = l.fillet(20.0, l.edges("|Z"));
let l = l - box_centered(length - 2.0 * wall, width - 2.0 * wall, 10.0).translate([0, 0, 5.0 - wall]);
let rec = cylinder([0, 0, 10.0 - wall - 2.0], "Z", 31.0, 2.0) - cylinder([0, 0, 0], "Z", 29.0, 12.0);
let vents = [cylinder([0, 0, 0], "Z", 2.0, 12.0)];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; vents.push(cylinder([10.0 * cos(a), 10.0 * sin(a), 0], "Z", 2.0, 12.0)); }
for i in 0..12 { let a = i.to_float() * PI() / 6.0; vents.push(cylinder([20.0 * cos(a), 20.0 * sin(a), 0], "Z", 2.0, 12.0)); }
let handle = box_centered(50.0, 10.0, 6.0).translate([0, width / 2.0 - 20.0, 13.0 - 0.01]) - box_centered(40.0, 12.0, 4.0).translate([0, width / 2.0 - 20.0, 12.0]);
l + rec + handle - fuse_all(vents)
