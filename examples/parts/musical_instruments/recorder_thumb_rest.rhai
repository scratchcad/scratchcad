// Soprano recorder thumb rest: clips on a 24 mm body, 20 mm wide, 8 mm shelf, 2.5 mm wall
let body_d = 24.0; // [20.0, 32.0] Recorder body diameter (mm)
let width = 20.0; // [12.0, 25.0] Width (mm)
let shelf = 8.0; // [5.0, 12.0] Thumb shelf depth (mm)
let wall = 2.5; // [1.5, 3.5] Wall (mm)
let r = body_d / 2.0;
let clip = cylinder(r + wall, width) - cylinder([0, 0, -1], "Z", r, width + 2.0) - box_from_corners([-r * 0.7, r * 0.5, -1], [r * 0.7, r + wall + 1.0, width + 1.0]);
let rest = box_from_corners([-6.0, -r - wall - shelf, 0], [6.0, -r - 0.5, 4.0]);
let rr = rest.fillet(1.5, rest.edges("|Z and <Y"));
clip + rr
