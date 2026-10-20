// Molecular model bond rod: 4 mm x 30 mm with 0.4 mm chamfers and a center grip ring
let d = 4.0; // [3.0, 6.0] Rod diameter (mm)
let length = 30.0; // [15.0, 60.0] Rod length (mm)
let r = cylinder(d / 2.0, length);
let rr = r.chamfer(0.4, r.edges("%CIRCLE"));
rr + cylinder([0, 0, length / 2.0 - 1.0], "Z", d / 2.0 + 0.6, 2.0)
