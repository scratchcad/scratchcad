// Bed centre rail support foot: adjustable leg saddle for a 50 x 25 mm rail, 3 mm walls 30 mm tall, on a 20 mm boss that takes an M10 threaded leg (8.5 mm tapped)
let rail_w = 50.0; // [30.0, 70.0] Rail width (mm)
let rail_h = 30.0; // [20.0, 40.0] Saddle wall height (mm)
const wall = 3.0;
let saddle = box_from_corners([-rail_w / 2.0 - wall, -25.0, 0], [rail_w / 2.0 + wall, 25.0, rail_h + wall]) - box_from_corners([-rail_w / 2.0, -26.0, wall], [rail_w / 2.0, 26.0, rail_h + wall + 1.0]);
let boss = cylinder([0, 0, -20.0], "Z", 10.0, 20.01);
let screws = cylinder([-rail_w / 2.0 - wall - 1.0, 0, wall + rail_h / 2.0], "X", 2.0, rail_w + 2.0 * wall + 2.0);
saddle + boss - cylinder([0, 0, -21.0], "Z", 4.25, 18.0) - screws
