// Pet food scoop, 250 ml: 85 x 70 mm square-bottom cup 55 mm deep, 2 mm wall, 100 mm flat handle
let length = 85.0; // [60.0, 120.0] Cup length (mm)
let width = 70.0; // [50.0, 100.0] Cup width (mm)
let depth = 55.0; // [35.0, 80.0] Cup depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let cup = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, depth]);
let c = cup.fillet(15.0, cup.edges("|Z"));
let cavity = box_from_corners([wall, -width / 2.0 + wall, wall], [length - wall, width / 2.0 - wall, depth + 1.0]);
let cv = cavity.fillet(13.0, cavity.edges("|Z"));
let lip = box_from_corners([length * 0.5, -width, depth * 0.6], [length * 2.0, width, depth * 2.0]).rotate([length * 0.5, 0, depth * 0.6], "Y", -20.0);
let handle = box_from_corners([-100.0, -10.0, depth - 6.0], [wall + 0.01, 10.0, depth - 2.0]);
let h = handle.fillet(9.0, handle.edges("|Z and <X"));
c - cv - lip + h
