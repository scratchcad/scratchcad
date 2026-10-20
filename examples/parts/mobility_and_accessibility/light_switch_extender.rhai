// Light switch extender: clip-on rocker extension for an 86 mm UK/EU wall switch, 30 x 15 mm rocker sleeve 8 mm deep, 150 mm downward reach bar 15 x 6 mm with a 25 mm push paddle, for wheelchair users and children
// # Rocker
let rocker_w = 30.0; // [20.0, 40.0] Rocker width (mm)
let rocker_h = 15.0; // [10.0, 25.0] Rocker height (mm)
let sleeve_depth = 8.0; // [5.0, 12.0] Sleeve depth (mm)
// # Reach bar
let reach = 150.0; // [80.0, 250.0] Reach length (mm)
let bar_w = 15.0; // [10.0, 20.0] Bar width (mm)
let bar_t = 6.0; // [4.0, 10.0] Bar thickness (mm)
const wall = 2.0;
let sleeve = box_from_corners([-rocker_w / 2.0 - wall, -sleeve_depth, -rocker_h / 2.0 - wall], [rocker_w / 2.0 + wall, wall, rocker_h / 2.0 + wall]);
let socket = box_from_corners([-rocker_w / 2.0, -sleeve_depth - 1.0, -rocker_h / 2.0], [rocker_w / 2.0, 0, rocker_h / 2.0]);
let bar = box_from_corners([-bar_w / 2.0, 0, -reach], [bar_w / 2.0, bar_t, -rocker_h / 2.0]);
let paddle = cylinder([0, 0, -reach], "Y", 12.5, bar_t);
let rib = box_from_corners([-1.0, bar_t - 0.01, -reach + 15.0], [1.0, bar_t + 2.0, -rocker_h / 2.0 - wall]);
(sleeve - socket) + bar + paddle + rib
