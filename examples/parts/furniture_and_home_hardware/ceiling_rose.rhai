// Ceiling rose: 110 mm stepped plaster-style disc 25 mm tall with two decorative beads, 12 mm cable hole, two screw holes 50 mm apart
let d = 110.0; // [80.0, 200.0] Diameter (mm)
let r = d / 2.0;
let rose = sketch("XZ").move_to(0, 0).line_to(r, 0).line_to(r, 4.0).arc_to(r - 4.0, 8.0, r - 8.0, 9.0).line_to(r * 0.6, 12.0).arc_to(r * 0.55, 15.0, r * 0.5, 16.0).line_to(r * 0.3, 22.0).line_to(r * 0.2, 25.0).line_to(0, 25.0).close().to_face().revolve("Z", 360);
rose = rose + torus(r * 0.75, 1.5).translate([0, 0, 10.5]);
rose -= cylinder([0, 0, -1], "Z", 6.0, 30.0);
for x in [-25.0, 25.0] { rose -= cylinder([x, 0, -1], "Z", 2.25, 30.0); }
rose
