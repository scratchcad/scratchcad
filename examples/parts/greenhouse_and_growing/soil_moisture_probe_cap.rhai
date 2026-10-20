// Soil moisture probe cap: weatherproof cap for a capacitive soil moisture sensor v1.2 (23 x 98 mm board), 28 x 8 mm board slot 30 mm deep, 34 x 14 mm outer shell with 1.5 mm wall, 6 mm cable gland boss and drip skirt
// # Board
let board_w = 23.0; // [15.0, 35.0] Board width (mm)
let board_t = 5.0; // [2.0, 10.0] Board thickness with parts (mm)
let cover_depth = 30.0; // [20.0, 45.0] Covered length (mm)
// # Shell
let wall = 1.5; // [1.2, 3.0] Wall thickness (mm)
let cable = 6.0; // [3.0, 8.0] Cable diameter (mm)
let iw = board_w + 1.0;
let it = board_t + 1.0;
let ow = iw + 2.0 * wall;
let ot = it + 2.0 * wall;
let shell = box_centered(ow, ot, cover_depth + wall).translate([0, 0, (cover_depth + wall) / 2.0]).fillet(min(ot / 2.0 - 0.5, 3.0), "|Z");
let cavity = box_centered(iw, it, cover_depth).translate([0, 0, cover_depth / 2.0 - 0.01]);
let skirt = (box_centered(ow + 6.0, ot + 6.0, 3.0).translate([0, 0, 1.5]).fillet(3.0, "|Z")) - box_centered(ow - 0.5, ot - 0.5, 10.0);
let boss = cylinder([0, 0, cover_depth + wall - 0.01], "Z", cable / 2.0 + 2.5, 8.0);
let cable_hole = cylinder([0, 0, cover_depth - 1.0], "Z", cable / 2.0, 12.0);
shell - cavity + skirt + boss - cable_hole
