// Flush-mount rod holder rain cap: 50 mm tube cap 30 mm deep, 2.5 mm wall, 60 mm flange with a lanyard eye
let tube = 50.0; // [40.0, 60.0] Holder ID (mm)
let depth = 30.0; // [15.0, 40.0] Plug depth (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let cap = cylinder(tube / 2.0 + 5.0, 3.0) + cylinder([0, 0, -depth], "Z", tube / 2.0 - 0.3, depth + 0.01);
let c = cap - cylinder([0, 0, -depth - 1.0], "Z", tube / 2.0 - 0.3 - wall, depth);
let eye = cylinder([tube / 2.0 + 5.0, -2.0, 1.5], "Y", 4.0, 4.0) - cylinder([tube / 2.0 + 5.0, -3.0, 1.5], "Y", 2.0, 6.0);
c + eye
