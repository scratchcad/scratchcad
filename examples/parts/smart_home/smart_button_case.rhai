// Wireless button case: 45 mm round, 12 mm tall, CR2032 cradle 20.5 mm, 0.8 mm flexing top membrane with a 12 mm plunger
let d = 45.0; // [35.0, 60.0] Case diameter (mm)
let height = 12.0; // [9.0, 18.0] Case height (mm)
let wall = 1.6; // [1.2, 2.5] Wall (mm)
let case_ = cylinder(d / 2.0, height);
let c = case_.fillet(3.0, case_.edges(">Z"));
let cav = cylinder([0, 0, wall], "Z", d / 2.0 - wall, height - 0.8 - wall);
let plunger = cylinder([0, 0, height - 4.0], "Z", 6.0, 3.21);
let groove = cylinder([0, 0, height - 0.5], "Z", 9.0, 1.0) - cylinder([0, 0, height - 1.0], "Z", 8.0, 2.0);
let cradle = cylinder([0, 0, 0], "Z", 11.5, 3.0) - cylinder([0, 0, -1], "Z", 10.25, 5.0) - box_from_corners([-12.0, -3.0, -1], [0, 3.0, 4.0]);
c - cav + plunger - groove + cradle.translate([0, 0, wall - 0.01])
