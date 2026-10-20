// Wooden spinning top: 45 mm body with a ridged rim, 6 mm spindle 25 mm tall, hardened ball tip
let d = 45.0; // [25.0, 80.0] Body diameter (mm)
let r = d / 2.0;
let top = sketch("XZ").move_to(0, 2.0).line_to(r * 0.5, 8.0).line_to(r, 18.0).line_to(r, 22.0).arc_to(r * 0.7, 27.0, 4.0, 28.0).line_to(0, 28.0).close().to_face().revolve("Z", 360);
fuse_all([top, torus(r - 0.5, 1.0).translate([0, 0, 20.0]), cylinder([0, 0, 27.0], "Z", 3.0, 25.0).fillet(1.0, ">Z"), sphere([0, 0, 2.5], 2.5)])
