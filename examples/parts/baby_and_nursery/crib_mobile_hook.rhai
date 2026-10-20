// Crib mobile arm clamp: fits 20 to 40 mm rails, 50 mm wide C, 20 mm arm socket, M6 thumbscrew boss
let rail = 40.0; // [20.0, 60.0] Max rail size (mm)
let width = 50.0; // [30.0, 70.0] Clamp width (mm)
let t = 6.0; // [4.0, 10.0] Wall (mm)
let socket = 20.0; // [15.0, 30.0] Arm socket diameter (mm)
let c = box_from_corners([0, 0, 0], [rail + 2.0 * t, width, rail + 2.0 * t]) - box_from_corners([t, -1, t], [rail + 2.0 * t + 1.0, width + 1.0, rail + t]);
let boss = cylinder([rail * 0.7, width / 2.0, -10.0], "Z", 8.0, 10.01);
let s = cylinder([0, width / 2.0, rail + 2.0 * t - 0.01], "Z", socket / 2.0 + 3.0, 30.0).translate([t, 0, 0]) - cylinder([t, width / 2.0, rail + 2.0 * t + 5.0], "Z", socket / 2.0, 30.0);
c + boss + s - cylinder([rail * 0.7, width / 2.0, -11.0], "Z", 2.5, t + 12.0)
