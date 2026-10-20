// Monitor arm desk C-clamp: up to 45 mm desk, 60 mm wide, 8 mm walls, 35 mm pole socket, M10 clamp screw boss
let desk = 45.0; // [20.0, 80.0] Max desk thickness (mm)
let width = 60.0; // [40.0, 80.0] Clamp width (mm)
let t = 8.0; // [5.0, 12.0] Wall (mm)
let reach = 70.0; // [50.0, 100.0] Jaw reach (mm)
let c = box_from_corners([0, 0, 0], [reach, width, desk + 2.0 * t]) - box_from_corners([t, -1, t], [reach + 1.0, width + 1.0, desk + t]);
let socket = cylinder([reach / 2.0 + 10.0, width / 2.0, desk + 2.0 * t - 0.01], "Z", 17.5 + 4.0, 30.0) - cylinder([reach / 2.0 + 10.0, width / 2.0, desk + 2.0 * t + 5.0], "Z", 17.5, 30.0);
let boss = cylinder([reach / 2.0 + 10.0, width / 2.0, -12.0], "Z", 12.0, 12.01);
c + socket + boss - cylinder([reach / 2.0 + 10.0, width / 2.0, -13.0], "Z", 4.25, t + 14.0)
