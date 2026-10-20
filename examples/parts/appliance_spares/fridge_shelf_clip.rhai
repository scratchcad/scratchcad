// Fridge glass shelf support clip: 4 mm glass, 40 x 12 mm, peg 6 mm into the liner, 15 mm grip depth
let glass = 4.0; // [3.0, 6.0] Glass thickness (mm)
let length = 40.0; // [25.0, 60.0] Clip length (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let t = 2.0; // [1.5, 3.0] Wall (mm)
let u = box_from_corners([0, 0, 0], [length, width, glass + 2.0 * t]) - box_from_corners([t, -1, t], [length + 1.0, width + 1.0, glass + t]);
let p = cylinder([-6.0, width / 2.0, glass / 2.0 + t], "X", 3.0, 6.01);
u + p
