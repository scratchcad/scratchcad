// Ball valve lockout: clamshell half cover for a 1/2 to 1 in lever ball valve, 90 x 55 x 45 mm box, 3 mm wall, 34 mm pipe saddle notches each end, 9 mm padlock hole in the 20 mm tab
let length = 90.0; // [70.0, 140.0] Cover length (mm)
let width = 55.0; // [40.0, 80.0] Cover width (mm)
let height = 45.0; // [30.0, 70.0] Cover height (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
let pipe = 34.0; // [21.0, 42.0] Pipe notch diameter (mm)
let outer = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, height]);
let o = outer.fillet(5.0, outer.edges("|Z or >Z"));
let inner = box_from_corners([-length / 2.0 + wall, -width / 2.0 + wall, -1.0], [length / 2.0 - wall, width / 2.0 - wall, height - wall]);
let cover = o - inner;
let notches = cylinder([-length, 0, 0], "X", pipe / 2.0, length * 2.0);
let tab = box_from_corners([length / 2.0 - 0.01 - 2.0, -wall / 2.0 - 1.0, 0], [length / 2.0 + 20.0, wall / 2.0 + 1.0, 25.0]);
let tb = tab.fillet(6.0, tab.edges("|Y and >X"));
(cover + tb) - notches - cylinder([length / 2.0 + 12.0, -10.0, 15.0], "Y", 4.5, 20.0)
