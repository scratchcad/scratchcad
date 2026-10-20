// Rubber stamp handle and mount: 40 x 25 mm mount block 12 mm tall, turned 22 mm knob handle 50 mm tall, 2 mm die recess underneath
let w = 40.0; // [25.0, 60.0] Stamp width (mm)
let d = 25.0; // [15.0, 40.0] Stamp depth (mm)
let block = box_centered(w, d, 12.0).translate([0, 0, 6.0]).chamfer(1.5, ">Z") - box_centered(w - 2.0, d - 2.0, 4.0);
let handle = sketch("XZ").move_to(0, 11.9).line_to(7.0, 11.9).line_to(5.0, 20.0).arc_to(5.5, 35.0, 9.0, 48.0).arc_to(7.0, 60.0, 0, 62.0).close().to_face().revolve("Z", 360);
block + handle
