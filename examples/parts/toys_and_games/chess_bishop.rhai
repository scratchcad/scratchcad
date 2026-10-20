// Staunton chess bishop: 32 mm base 70 mm tall, slender stem, mitre with a slanted slot and a ball finial
let h = 70.0; // [50.0, 95.0] Height (mm)
let s = h / 70.0;
let b = sketch("XZ").move_to(0, 0).line_to(16.0 * s, 0).line_to(16.0 * s, 4.0 * s).arc_to(15.0 * s, 7.0 * s, 11.0 * s, 8.0 * s).line_to(6.0 * s, 36.0 * s).line_to(10.0 * s, 39.0 * s).line_to(10.0 * s, 41.0 * s).line_to(6.0 * s, 42.0 * s).arc_to(10.0 * s, 52.0 * s, 0, 64.0 * s).close().to_face().revolve("Z", 360);
b = b - box_centered(2.0 * s, 30.0 * s, 12.0 * s).rotate_y(35.0).translate([3.0 * s, 0, 54.0 * s]);
b + sphere([0, 0, 66.0 * s], 3.0 * s) - cylinder([0, 0, -1.0], "Z", 13.0 * s, 1.8)
