// Flight controller soft-mount grommet: 8 mm rubber barrel 4.6 mm tall, 1.6 mm PCB groove to 5.2 mm, 3 mm bore
let pcb = 1.6; // [0.8, 2.0] PCB thickness (mm)
let g = sketch("XZ").move_to(1.5, 0).line_to(4.0, 0).line_to(4.0, 1.5).line_to(2.6, 1.5).line_to(2.6, 1.5 + pcb).line_to(4.0, 1.5 + pcb).line_to(4.0, 3.0 + pcb).line_to(1.5, 3.0 + pcb).close();
g.to_face().revolve("Z", 360)
