// PC4-M6 push-in Bowden coupler: M6 thread 6 mm, 9 mm hex 4 mm tall, 10 mm collet body, 4 mm tube bore
let tube_d = 4.0; // [3.0, 6.0] Tube diameter (mm)
let hex = 9.0; // [8.0, 12.0] Hex size (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let body = cylinder([0, 0, -6.0], "Z", 3.0, 6.01) + polygon(pts).to_face().extrude(4.0) + cylinder([0, 0, 3.99], "Z", 5.0, 5.0) + cylinder([0, 0, 8.99], "Z", 4.5, 2.0);
body - cylinder([0, 0, -7], "Z", 1.0, 30) - cylinder([0, 0, -2.0], "Z", tube_d / 2.0 + 0.05, 20)
