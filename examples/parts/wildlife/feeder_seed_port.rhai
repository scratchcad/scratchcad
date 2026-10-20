// Tube bird feeder seed port: fits a 55 mm tube hole of 25 mm, 30 mm port with a 12 x 8 mm seed opening and a 6 mm perch 60 mm
let tube = 55.0; // [40.0, 80.0] Feeder tube OD (mm)
let hole = 25.0; // [18.0, 32.0] Tube hole diameter (mm)
let port = cylinder([0, 0, 0], "Y", hole / 2.0 + 4.0, 10.0) - cylinder([0, tube / 2.0 + 10.0, 0], "Z", tube / 2.0, 1.0).translate([0, 0, -0.5]);
let p = cylinder([0, -6.0, 0], "Y", hole / 2.0 - 0.3, 6.01) + port;
let opening = box_centered(12.0, 30.0, 8.0).translate([0, 0, -2.0]);
let perch = cylinder([-30.0, 6.0, -hole / 2.0 - 2.0], "X", 3.0, 60.0);
let arm = box_from_corners([-3.0, 2.0, -hole / 2.0 - 4.0], [3.0, 10.0, -hole / 2.0 + 1.0]);
p - opening + perch + arm
