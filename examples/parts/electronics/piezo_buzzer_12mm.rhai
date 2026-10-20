// 12 mm active buzzer: 12 x 9.5 mm body with a 2 mm sound hole, sealed label, leads 7.6 mm apart (+ longer)
let diameter = 12.0; // [9.0, 16.0] Diameter (mm)
let height = 9.5; // [5.0, 12.0] Height (mm)
let body = cylinder(diameter / 2.0, height).fillet(0.5, ">Z") - cylinder([0, 0, height - 1.0], "Z", 1.0, 2.0);
body = body - (cylinder([0, 0, height - 0.3], "Z", diameter / 2.0 - 1.0, 1.0) - cylinder([0, 0, height - 1.0], "Z", diameter / 2.0 - 1.5, 2.0));
body + cylinder([-3.8, 0, -4.0], "Z", 0.3, 4.01) + cylinder([3.8, 0, -6.0], "Z", 0.3, 6.01)
