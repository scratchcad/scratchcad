// Trumpet mouthpiece, 7C style: 16.3 mm cup diameter, rounded rim 26 mm across, cup depth 8 mm, 3.66 mm throat (#27), backbore to a 9.9 mm shank 88 mm overall
let cup = 16.3; // [15.0, 18.0] Cup diameter (mm)
let rc = cup / 2.0;
let outer = sketch("XZ").move_to(1.83, 0).line_to(13.0, 0).arc_to(13.8, 2.5, 12.0, 5.0).line_to(8.5, 20.0).line_to(6.0, 40.0).line_to(5.2, 88.0).line_to(4.95 - 0.7, 88.0).line_to(4.3, 60.0).line_to(1.83, 13.0).arc_to(rc * 0.6, 6.0, rc, 0.8).arc_to(rc + 1.2, 0.2, rc + 2.5, 0.8).line_to(1.83, 0.8).close();
let mp = sketch("XZ").move_to(rc, 0).arc_to(rc + 2.4, -1.2, rc + 4.8, 0).line_to(13.0, 4.0).line_to(8.5, 20.0).line_to(6.0, 40.0).line_to(5.0, 88.0).line_to(4.3, 88.0).line_to(3.6, 60.0).line_to(1.83, 13.0).line_to(1.83, 10.0).arc_to(rc * 0.65, 6.5, rc, 0).close();
mp.to_face().revolve("Z", 360)
