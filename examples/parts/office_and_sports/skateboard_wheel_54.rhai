// Skateboard wheel 54 mm x 32 mm contact, 99A urethane: rounded profile, 22 mm bearing seats 7 mm deep both sides, 8 mm axle hole
let d = 54.0; // [48.0, 60.0] Wheel diameter (mm)
let w = 32.0; // [28.0, 40.0] Width (mm)
let r = d / 2.0;
let wheel = cylinder(r, w).fillet(6.0, "%CIRCLE");
wheel - cylinder([0, 0, -1], "Z", 11.0, 8.0) - cylinder([0, 0, w - 7.0], "Z", 11.0, 8.0) - cylinder([0, 0, -1], "Z", 4.1, w + 2.0) - cylinder([0, 0, 7.0], "Z", 9.0, w - 14.0)
