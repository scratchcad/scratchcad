// Inline cord switch housing half: 60 x 22 x 9 mm shell, 1.5 mm wall, 12 x 6 mm rocker window, 2 cord grips 5 mm, 2 screw bosses
let length = 60.0; // [45.0, 80.0] Length (mm)
let width = 22.0; // [16.0, 30.0] Width (mm)
let height = 9.0; // [6.0, 14.0] Half height (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let shell = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let s = shell.fillet(width / 2.0 - 1.0, shell.edges("|Z"));
let cavity = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 + wall]);
let cv = cavity.fillet(width / 2.0 - wall - 1.0, cavity.edges("|Z"));
let bosses = cylinder([-15.0, 0, wall - 0.01], "Z", 3.0, height - wall) + cylinder([15.0, 0, wall - 0.01], "Z", 3.0, height - wall);
let cord = cylinder([-length, 0, height], "X", 2.5, length * 2.0);
s - cv + bosses - cord - box_centered(12.0, 6.0, 4.0).translate([0, 0, 0]) - cylinder([-15.0, 0, -1], "Z", 1.2, height + 2.0) - cylinder([15.0, 0, -1], "Z", 1.2, height + 2.0)
