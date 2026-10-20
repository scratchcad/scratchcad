// Stylised chess knight: 34 mm turned base, 30 mm tall horse head profile 14 mm thick with ears, eye holes and a mane groove
let s = 1.0; // [0.7, 1.5] Scale
let base = sketch("XZ").move_to(0, 0).line_to(17.0 * s, 0).line_to(17.0 * s, 4.0 * s).arc_to(16.0 * s, 7.0 * s, 12.0 * s, 8.0 * s).line_to(10.0 * s, 14.0 * s).line_to(0, 14.0 * s).close().to_face().revolve("Z", 360);
let head = polygon([[-9, 0, 13], [9, 0, 13], [11, 0, 22], [8, 0, 32], [10, 0, 44], [6, 0, 50], [1, 0, 53], [-4, 0, 50], [-16, 0, 38], [-17, 0, 33], [-12, 0, 31], [-6, 0, 34], [-4, 0, 28], [-9, 0, 20]]).to_face().extrude([0, 14.0, 0]).translate([0, -7.0, 0]).scale(s);
head = head.fillet(1.5 * s, "|Y") - cylinder([-4.0 * s, -8.0 * s, 42.0 * s], "Y", 1.5 * s, 16.0 * s) - box_centered(2.0 * s, 16.0 * s, 4.0 * s).translate([3.0 * s, 0, 51.0 * s]);
base + head - cylinder([0, 0, -1.0], "Z", 14.0 * s, 1.8)
