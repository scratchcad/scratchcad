// Toothbrush holder cup: 70 mm diameter, 110 mm tall, 2.5 mm walls, lid with 4 brush holes of 14 mm
let diameter = 70.0; // [50.0, 100.0] Diameter (mm)
let height = 110.0; // [60.0, 160.0] Height (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let holes = 4; // [1, 8] Brush holes
let cup = cylinder(diameter / 2.0, height).fillet(5.0, "<Z").shell(-wall, ">Z");
let lid = cylinder([0, 0, height - 0.01], "Z", diameter / 2.0, 3.0) - cylinder([0, 0, height - 1], "Z", 6.0, 5.0);
for i in 0..holes { lid -= cylinder([diameter * 0.27, 0, height - 1], "Z", 7.0, 5.0).rotate_z(i.to_float() * 360.0 / holes.to_float()); }
cup + lid
