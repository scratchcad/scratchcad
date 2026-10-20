// Poultry nipple drinker saddle for 22 mm square pipe: 30 mm long clamp, 3/8 in nipple boss 14 mm
let pipe = 22.0; // [18.0, 30.0] Pipe size (mm)
let length = 30.0; // [20.0, 40.0] Saddle length (mm)
let wall = 2.5; // [1.5, 4.0] Wall (mm)
let sad = box_centered(length, pipe + 2.0 * wall, pipe + 2.0 * wall) - box_centered(length + 2.0, pipe + 0.4, pipe + 0.4) - box_centered(length + 2.0, pipe * 0.7, pipe).translate([0, 0, pipe / 2.0]);
let boss = cylinder([0, 0, -pipe / 2.0 - wall - 10.0], "Z", 7.0, 10.01);
sad + boss - cylinder([0, 0, -pipe / 2.0 - wall - 11.0], "Z", 4.3, 14.0)
