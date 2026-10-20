// Drum tuning key: 5.6 mm square socket in a 9 mm barrel 25 mm long, 38 mm wing handle 3 mm thick
let wing = 38.0; // [30.0, 50.0] Handle width (mm)
let barrel = cylinder(4.5, 25.0) - box_centered(5.6, 5.6, 22.0).translate([0, 0, 10.0]);
let handle = sketch("XZ").move_to(-wing / 2.0, 20.0).line_to(wing / 2.0, 20.0).arc_to(wing / 2.0 - 4.0, 34.0, 0, 38.0).arc_to(-wing / 2.0 + 4.0, 34.0, -wing / 2.0, 20.0).close().to_face().extrude(3.0).translate([0, 1.5, 0]);
barrel + handle - cylinder([0, -3.0, 31.0], "Y", 4.0, 6.0)
