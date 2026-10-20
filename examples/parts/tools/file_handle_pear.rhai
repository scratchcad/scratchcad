// Pear-shaped file handle: 32 mm belly 110 mm long, 16 mm brass ferrule 12 mm long, 6 mm tang hole 60 mm deep
let len = 110.0; // [80.0, 150.0] Handle length (mm)
let belly = 16.0; // [12.0, 22.0] Belly radius (mm)
let h = sketch("XZ").move_to(0, 0).line_to(8.0, 0).line_to(8.0, 12.0).line_to(10.0, 14.0).arc_to(belly, len * 0.55, belly * 0.8, len * 0.85).arc_to(belly * 0.45, len * 0.98, 0, len).close().to_face().revolve("Z", 360);
h - cylinder([0, 0, -1], "Z", 3.0, 61.0)
