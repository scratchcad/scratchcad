// Oil level sight glass, G1/4: 18 mm flange, 13 mm thread 8 mm, 10 mm window recess 3 mm, 6 mm hex socket
let flange_d = 18.0; // [14.0, 30.0] Flange diameter (mm)
let thread_d = 13.0; // [10.0, 21.0] Thread (mm)
let window = 10.0; // [6.0, 18.0] Window diameter (mm)
let body = cylinder(flange_d / 2.0, 3.0) + cylinder([0, 0, -8.0], "Z", thread_d / 2.0, 8.01);
let b = body.chamfer(0.5, body.edges(">Z"));
b - cylinder([0, 0, 1.0], "Z", window / 2.0, 3.0) - cylinder([0, 0, -9.0], "Z", window / 2.0 - 1.5, 12.0)
