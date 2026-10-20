// Staunton chess king: 38 mm base 95 mm tall, crown with a cross finial
let h = 95.0; // [70.0, 120.0] Height (mm)
let s = h / 95.0;
let k = sketch("XZ").move_to(0, 0).line_to(19.0 * s, 0).line_to(19.0 * s, 4.0 * s).arc_to(18.0 * s, 8.0 * s, 13.0 * s, 9.0 * s).line_to(7.0 * s, 55.0 * s).line_to(12.0 * s, 58.0 * s).line_to(12.0 * s, 60.0 * s).line_to(7.5 * s, 61.0 * s).line_to(11.0 * s, 75.0 * s).line_to(5.0 * s, 78.0 * s).line_to(0, 78.0 * s).close().to_face().revolve("Z", 360);
let cross = box_centered(4.0 * s, 4.0 * s, 16.0 * s).translate([0, 0, 85.0 * s]) + box_centered(12.0 * s, 4.0 * s, 4.0 * s).translate([0, 0, 88.0 * s]);
k + cross - cylinder([0, 0, -1.0], "Z", 15.0 * s, 1.8)
