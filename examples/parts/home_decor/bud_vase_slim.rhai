// Slim bud vase: 180 mm tall, 45 mm belly, 18 mm neck, 2 mm wall, 10 mm solid weighted base
let height = 180.0; // [100.0, 300.0] Height (mm)
let belly = 45.0; // [30.0, 80.0] Belly diameter (mm)
let neck = 18.0; // [10.0, 30.0] Neck diameter (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = sketch("XZ").move_to(0, 0).hline_to(belly * 0.4).arc_to(belly / 2.0, height * 0.25, neck / 2.0 + 2.0, height * 0.6).line_to(neck / 2.0, height - 10.0).line_to(neck / 2.0 + 2.0, height).hline_to(0).close();
let o = outer.face().revolve("Z", 360);
let inner = cylinder([0, 0, 10.0], "Z", neck / 2.0 - wall, height);
o - inner
