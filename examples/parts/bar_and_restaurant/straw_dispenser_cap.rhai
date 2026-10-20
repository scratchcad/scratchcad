// Straw dispenser lid: 75 mm tube cap 15 mm skirt, 8 mm single-straw exit hole on a 20 mm cone, 2 mm wall
let tube = 75.0; // [50.0, 100.0] Tube OD (mm)
let skirt = 15.0; // [10.0, 25.0] Skirt depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let exit = 8.0; // [6.0, 14.0] Exit hole (mm)
let cap = cylinder(tube / 2.0 + wall, skirt + wall) + cone(tube / 2.0 + wall, exit / 2.0 + wall, 20.0).translate([0, 0, skirt + wall - 0.01]);
cap - cylinder([0, 0, -1], "Z", tube / 2.0, skirt + 1.0) - cone(tube / 2.0, exit / 2.0, 20.0).translate([0, 0, skirt - 0.01]) - cylinder([0, 0, skirt], "Z", exit / 2.0, 30.0)
