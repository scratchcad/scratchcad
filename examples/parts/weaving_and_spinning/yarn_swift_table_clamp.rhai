// Yarn swift table clamp: up to 40 mm tabletop, 50 mm wide C, 8 mm walls, 16 mm swift spindle socket 40 mm deep
let table = 40.0; // [20.0, 60.0] Max tabletop thickness (mm)
let width = 50.0; // [35.0, 70.0] Clamp width (mm)
let t = 8.0; // [6.0, 12.0] Wall (mm)
let c = box_from_corners([0, 0, 0], [60.0, width, table + 2.0 * t]) - box_from_corners([t, -1, t], [61.0, width + 1.0, table + t]);
let socket = cylinder([-12.0, width / 2.0, 0], "Z", 12.0, table + 2.0 * t) - cylinder([-12.0, width / 2.0, table + 2.0 * t - 40.0], "Z", 8.2, 41.0);
let web = box_from_corners([-12.0, width / 2.0 - 8.0, 0], [0.01, width / 2.0 + 8.0, table + 2.0 * t]);
let boss = cylinder([40.0, width / 2.0, -12.0], "Z", 9.0, 12.01);
c + socket + web + boss - cylinder([40.0, width / 2.0, -13.0], "Z", 4.25, t + 14.0) - cylinder([-12.0, width / 2.0, table + 2.0 * t - 40.0], "Z", 8.2, 41.0)
