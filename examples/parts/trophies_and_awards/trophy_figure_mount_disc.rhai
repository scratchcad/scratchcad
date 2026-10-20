// Trophy figure mounting disc: 30 mm disc 6 mm thick with an M4 threaded stud boss (3.3 mm tap drill, 8 mm deep), 2 locating pins 2 mm dia 3 mm tall and a 1 mm chamfer
let dia = 30.0; // [20.0, 45.0] Disc diameter (mm)
let t = 6.0; // [4.0, 10.0] Disc thickness (mm)
let d = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let d = d.chamfer(1.0, d.edges(">Z"));
let pins = cylinder([-dia / 2.0 + 5.0, 0, t - 0.01], "Z", 1.0, 3.0) + cylinder([dia / 2.0 - 5.0, 0, t - 0.01], "Z", 1.0, 3.0);
d + pins - cylinder([0, 0, -1.0], "Z", 1.65, 9.0)
