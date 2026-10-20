// Staunton chess pawn: 28 mm base 50 mm tall, turned profile with collar and ball head, felt recess underneath
let h = 50.0; // [35.0, 70.0] Height (mm)
let s = h / 50.0;
let p = sketch("XZ").move_to(0, 0).line_to(14.0 * s, 0).line_to(14.0 * s, 3.0 * s).arc_to(13.0 * s, 6.0 * s, 10.0 * s, 7.0 * s).line_to(6.0 * s, 25.0 * s).line_to(9.0 * s, 28.0 * s).line_to(9.0 * s, 30.0 * s).line_to(5.0 * s, 31.0 * s).line_to(5.0 * s, 33.0 * s).line_to(0, 33.0 * s).close().to_face().revolve("Z", 360);
p + sphere([0, 0, 41.0 * s], 9.0 * s) - cylinder([0, 0, -1.0], "Z", 11.0 * s, 1.8)
