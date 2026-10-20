// Ball jet nozzle diffuser for a 100 mm duct, two bodies: housing with 99 mm OD spigot 40 mm, 130 mm face flange and a spherical socket for a 70 mm ball (0.4 mm clearance), and the ball with a 40 mm nozzle bore tilted 15 degrees
let spigot_d = 99.0; // [90.0, 160.0] Spigot outside diameter (mm)
let ball_d = 70.0; // [50.0, 80.0] Ball diameter (mm)
let nozzle_d = 40.0; // [20.0, 45.0] Nozzle bore (mm)
let tilt = 15.0; // [0.0, 25.0] Nozzle tilt (degrees)
let flange_d = 130.0; // [120.0, 200.0] Face flange diameter (mm)
const wall = 2.0;
const clearance = 0.4;
let rb = ball_d / 2.0;
let rs = spigot_d / 2.0;
let rf = max(flange_d / 2.0, rs + 8.0);
let flange_t = rb * 0.8;
// housing: flange block holding the ball, spigot above
let housing = cylinder([0, 0, -flange_t / 2.0], "Z", rf, flange_t) + cylinder([0, 0, flange_t / 2.0 - 0.5], "Z", rs, 40.5);
housing = housing - cylinder([0, 0, flange_t / 2.0], "Z", rs - wall, 42.0);
housing = housing - sphere(rb + clearance);
// the ball's nozzle bore runs through the ball; a cone flares into the housing above it
let ball = sphere(rb) - cylinder([0, 0, -rb - 1.0], "Z", nozzle_d / 2.0, 2.0 * rb + 2.0).rotate_x(tilt);
let ball_cut = ball & box_centered(2.0 * rb + 2.0, 2.0 * rb + 2.0, 2.0 * rb * 0.84);
compound([housing, ball_cut])
