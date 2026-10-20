// Spirit level vial holder: 40 x 16 x 16 mm block with a 10 mm vial bore, 25 x 8 mm sight window and two 3 mm screw holes
let len = 40.0; // [30.0, 60.0] Block length (mm)
let vial = 10.0; // [6.0, 14.0] Vial diameter (mm)
let b = box_centered(len, 16.0, 16.0).fillet(1.0) - cylinder([-len / 2.0 - 1.0, 0, 0], "X", vial / 2.0, len + 2.0);
b -= box_centered(25.0, 8.0, 10.0).translate([0, 0, 6.0]);
for x in [-len / 2.0 + 5.0, len / 2.0 - 5.0] { b -= cylinder([x, 0, -10.0], "Z", 1.5, 4.0); }
b
