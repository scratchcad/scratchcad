// Cistern ball-valve float: 114 mm (4-1/2 in) hollow sealed ball, 1.5 mm wall, 4 mm seam band, 14 mm boss with a blind 5 mm hole tapped M6 for the float arm
let diameter = 114.0; // [80.0, 150.0] Ball diameter (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let boss_d = 14.0; // [10.0, 20.0] Boss diameter (mm)
let boss_h = 6.0; // [4.0, 12.0] Boss height above the ball (mm)
let r = diameter / 2.0;
let shell = sphere(r) - sphere(r - wall);
let boss = cylinder([0, 0, r - 9.0], "Z", boss_d / 2.0, boss_h + 9.0);
let band = cylinder([0, 0, -2.0], "Z", r + 1.5, 4.0) - cylinder([0, 0, -3.0], "Z", r - wall - 0.5, 6.0);
shell + boss + band - cylinder([0, 0, r - 4.0], "Z", 2.5, boss_h + 5.0)
