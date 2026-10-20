// Propane cylinder valve protective cap: fits an 80 mm collar, 85 mm cap 60 mm tall, 2 x 30 mm hand slots, 2.5 mm wall
let collar = 80.0; // [60.0, 110.0] Collar diameter (mm)
let height = 60.0; // [40.0, 90.0] Cap height (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let cap = cylinder(collar / 2.0 + wall, height) - cylinder([0, 0, -1], "Z", collar / 2.0, height - wall + 1.0);
let slots = box_centered(30.0, collar * 2.0, 15.0).translate([0, 0, height * 0.55]);
let s = slots.fillet(7.0, slots.edges("|Y"));
cap - s
