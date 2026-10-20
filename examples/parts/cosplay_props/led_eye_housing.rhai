// Cosplay LED eye housing: 30 mm cup 12 mm deep with 1.5 mm walls holding a 25 mm diffuser, a 5 mm LED socket at the back and two 2 mm mounting ears
let lens = 25.0; // [15.0, 40.0] Diffuser diameter (mm)
let depth = 12.0; // [8.0, 20.0] Cup depth (mm)
const wall = 1.5;
let r = lens / 2.0 + 0.2;
let cup = cylinder([0, 0, 0], "Z", r + wall, depth) - cylinder([0, 0, wall], "Z", r, depth);
let seat = cylinder([0, 0, depth - 2.0], "Z", r + 0.01, 0.8) - cylinder([0, 0, depth - 3.0], "Z", r - 1.0, 3.0);
let ears = box_from_corners([-r - wall - 6.0, -3.0, 0], [r + wall + 6.0, 3.0, 2.0]) - cylinder([-r - wall - 3.0, 0, -1.0], "Z", 1.0, 4.0) - cylinder([r + wall + 3.0, 0, -1.0], "Z", 1.0, 4.0);
cup + seat + ears - cylinder([0, 0, -1.0], "Z", 2.6, wall + 2.0)
