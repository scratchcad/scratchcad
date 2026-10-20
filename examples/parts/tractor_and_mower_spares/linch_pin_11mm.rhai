// Tractor linch pin: 11 mm pin 60 mm long with a 2 mm flat ring clip loop 40 mm, tapered tip
let pin = 11.0; // [8.0, 16.0] Pin diameter (mm)
let length = 60.0; // [40.0, 90.0] Pin length (mm)
let p = cylinder([0, 0, 0], "Z", pin / 2.0, length - 4.0) + cone(pin / 2.0, pin / 2.0 - 2.0, 4.0).translate([0, 0, length - 4.01]);
let head = cylinder([0, 0, -6.0], "Z", pin / 2.0 + 3.0, 6.01) - cylinder([-10.0, 0, -3.0], "X", 1.5, 20.0);
let ring = (cylinder([0, -1.0, -3.0 - 20.0], "Y", 20.0, 2.0) - cylinder([0, -2.0, -3.0 - 20.0], "Y", 17.0, 4.0)) & box_from_corners([-30, -2, -60], [30, 2, -3.0]);
p + head + ring
