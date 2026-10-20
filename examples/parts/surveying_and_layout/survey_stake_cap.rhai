// Survey stake cap: fits a 50 x 50 mm wooden stake, 60 mm square cap 30 mm deep, 2 mm wall, crosshair mark on top
let stake = 50.0; // [38.0, 75.0] Stake size (mm)
let depth = 30.0; // [15.0, 50.0] Cap depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let c = box_centered(stake + 2.0 * wall + 1.0, stake + 2.0 * wall + 1.0, depth + wall).translate([0, 0, (depth + wall) / 2.0]);
let cc = c.fillet(3.0, c.edges("|Z"));
let cross = box_centered(stake * 0.8, 1.5, 2.0).translate([0, 0, depth + wall]) + box_centered(1.5, stake * 0.8, 2.0).translate([0, 0, depth + wall]);
cc - box_centered(stake + 1.0, stake + 1.0, depth * 2.0) - cross
