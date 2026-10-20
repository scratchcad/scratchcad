// Wingtip nav light lens: 70 x 35 mm base, 30 mm tall quarter-dome, 2 mm wall, mounting flange 5 mm with 3 holes
let length = 70.0; // [50.0, 100.0] Base length (mm)
let depth = 35.0; // [25.0, 50.0] Base depth (mm)
let height = 30.0; // [20.0, 45.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let shell = (cylinder([-length / 2.0, 0, 0], "X", height, length) & box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, height])) - (cylinder([-length / 2.0 - 1.0, 0, 0], "X", height - wall, length + 2.0));
let flange = box_from_corners([-length / 2.0 - 5.0, -0.01, -5.0], [length / 2.0 + 5.0, wall, height + 5.0]) - box_from_corners([-length / 2.0 + wall, -1, wall], [length / 2.0 - wall, wall + 1.0, height - wall]);
let caps = box_from_corners([-length / 2.0, 0, 0], [-length / 2.0 + wall, depth, height]) + box_from_corners([length / 2.0 - wall, 0, 0], [length / 2.0, depth, height]);
let e = (caps & cylinder([-length, 0, 0], "X", height, length * 2.0)) & box_from_corners([-length, 0, 0], [length, depth, height]);
shell + e + flange - cylinder([-length / 2.0 - 2.5, -1, height / 2.0], "Y", 1.5, 6.0) - cylinder([length / 2.0 + 2.5, -1, height / 2.0], "Y", 1.5, 6.0)
