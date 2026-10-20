// Cable railing swage end fitting body: 3.2 mm (1/8 in) cable bore 30 mm deep, 8 mm body 60 mm, 1/4-20 male stud 40 mm
let cable = 3.2; // [3.0, 5.0] Cable diameter (mm)
let body_d = 8.0; // [7.0, 12.0] Body diameter (mm)
let body_l = 60.0; // [40.0, 80.0] Body length (mm)
let stud_l = 40.0; // [20.0, 60.0] Stud length (mm)
let b = cylinder(body_d / 2.0, body_l) + cylinder([0, 0, body_l - 0.01], "Z", 3.17, stud_l);
b.chamfer(0.5, b.edges("<Z")) - cylinder([0, 0, -1], "Z", cable / 2.0 + 0.1, 31.0)
