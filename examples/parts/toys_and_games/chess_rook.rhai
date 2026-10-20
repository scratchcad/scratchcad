// Staunton chess rook: 32 mm base 55 mm tall, tapered tower, crenellated top with four slots, felt recess
let h = 55.0; // [40.0, 75.0] Height (mm)
let s = h / 55.0;
let r = sketch("XZ").move_to(0, 0).line_to(16.0 * s, 0).line_to(16.0 * s, 4.0 * s).arc_to(15.0 * s, 7.0 * s, 12.0 * s, 8.0 * s).line_to(9.0 * s, 40.0 * s).line_to(12.0 * s, 43.0 * s).line_to(12.0 * s, h).line_to(0, h).close().to_face().revolve("Z", 360);
r -= cylinder([0, 0, h - 5.0 * s], "Z", 8.5 * s, 10.0);
for a in [0.0, 45.0, 90.0, 135.0] { r -= box_centered(30.0 * s, 3.5 * s, 10.0 * s).translate([0, 0, h]).rotate("Z", a); }
r - cylinder([0, 0, -1.0], "Z", 13.0 * s, 1.8)
