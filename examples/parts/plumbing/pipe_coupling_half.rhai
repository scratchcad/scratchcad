// 3/4 in threaded half coupling: 35 mm OD, 26.7 mm pipe bore, 25 mm long, weld-on base chamfered at 45 degrees
let outer_d = 35.0; // [20.0, 80.0] Outside diameter (mm)
let pipe_od = 26.7; // [13.7, 60.3] Pipe OD (mm)
let length = 25.0; // [15.0, 50.0] Length (mm)
let body = cylinder(outer_d / 2.0, length).chamfer(2.0, "<Z");
body - cylinder([0, 0, -1], "Z", pipe_od / 2.0 - 1.0, length + 2.0) - cone(pipe_od / 2.0 - 0.6, pipe_od / 2.0 + 0.2, 15.0).translate([0, 0, length - 15.0 + 0.01])
