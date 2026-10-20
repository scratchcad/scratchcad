// Golf tee, 54 mm: 11 mm cupped head, 4.5 mm shank tapering to a point
let len = 54.0; // [42.0, 83.0] Tee length (mm)
let profile = sketch("XZ").move_to(0, 0).line_to(0.4, 0).line_to(2.25, 12.0).line_to(2.25, len - 8.0).line_to(5.5, len - 1.0).line_to(5.5, len).line_to(4.0, len).arc_to(2.0, len - 1.6, 0, len - 2.0).close();
profile.to_face().revolve("Z", 360)
