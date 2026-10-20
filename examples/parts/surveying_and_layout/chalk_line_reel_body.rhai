// Chalk line reel half shell: 75 mm round body 20 mm deep, 2 mm wall, 12 mm line nose with 3 mm exit, axle boss 8 mm
let d = 75.0; // [55.0, 100.0] Body diameter (mm)
let depth = 20.0; // [14.0, 30.0] Half depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let shell = cylinder(d / 2.0, depth) - cylinder([0, 0, wall], "Z", d / 2.0 - wall, depth);
let nose = box_from_corners([d / 2.0 - 10.0, -6.0, 0], [d / 2.0 + 15.0, 6.0, depth]) - box_from_corners([d / 2.0 - 10.0, -6.0 + wall, wall], [d / 2.0 + 15.0 - wall, 6.0 - wall, depth + 1.0]);
let boss = cylinder(8.0, depth) - cylinder([0, 0, wall], "Z", 4.0, depth);
shell + nose + boss - cylinder([d / 2.0 + 13.0, 0, depth / 2.0], "X", 1.5, 5.0)
