// Stratocaster-style football jack plate: 28 x 56 mm dished plate, 22 mm jack cup 10 mm deep with a 9.5 mm hole, two screw holes 46 mm apart
let len = 56.0; // [48.0, 64.0] Plate length (mm)
let plate = (sketch().move_to(-len / 2.0, 0).arc_to(0, 14.0, len / 2.0, 0).arc_to(0, -14.0, -len / 2.0, 0).close().to_face().extrude(1.5)) + cylinder([0, 0, -10.0], "Z", 11.0, 10.1) - cylinder([0, 0, -9.0], "Z", 10.0, 12.0);
plate = plate + cylinder([0, 0, -10.0], "Z", 11.0, 1.5) - cylinder([0, 0, -11.0], "Z", 4.75, 4.0);
for x in [-23.0, 23.0] { plate -= cylinder([x, 0, -1], "Z", 1.6, 4.0) + cone(1.6, 3.0, 1.0).translate([x, 0, 0.51]); }
plate
