// Disc golf driver: 211 mm diameter, wide 22 mm rim with a sharp leading edge, 14 mm tall, 1.2 mm flight plate
let d = 211.0; // [205.0, 213.0] Diameter (mm)
let r = d / 2.0;
sketch("XZ").move_to(0, 14.0).arc_to(r * 0.5, 13.6, r - 22.0, 12.6).line_to(r - 4.0, 9.0).line_to(r, 5.0).line_to(r - 6.0, 0).line_to(r - 22.0, 0.5).line_to(r - 22.0, 11.4).arc_to(r * 0.5, 12.4, 0, 12.8).close().to_face().revolve("Z", 360)
