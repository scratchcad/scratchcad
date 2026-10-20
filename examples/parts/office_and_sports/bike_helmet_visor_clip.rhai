// Helmet visor clip: 18 x 10 mm base 2 mm thick, a split 6 mm push pin with a 7.5 mm barb, under a 10 mm flange
let pin = 6.0; // [4.0, 8.0] Pin diameter (mm)
let base = box_centered(18.0, 10.0, 2.0).translate([0, 0, 1.0]).fillet(3.0, "|Z");
let shaft = cylinder([0, 0, -8.0], "Z", pin / 2.0, 8.1) + cone(pin / 2.0 + 0.75, pin / 2.0 - 0.5, 3.0).translate([0, 0, -10.0]);
(base + shaft) - box_centered(1.2, pin + 4.0, 7.0).translate([0, 0, -7.5])
