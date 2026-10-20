// E3D V6 nozzle 0.4 mm: M6 x 1 thread 5 mm long, 7 mm hex 3 mm tall, conical tip, 2 mm bore narrowing to 0.4 mm
let orifice = 0.4; // [0.2, 1.2] Orifice diameter (mm)
let hex = 7.0; // [6.0, 10.0] Hex size (mm)
let thread_l = 5.0; // [4.0, 8.0] Thread length (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let body = polygon(pts).to_face().extrude(3.0).translate([0, 0, 2.0]) + cylinder([0, 0, 4.99], "Z", 3.0, thread_l + 0.01) + cone(1.0, hex * 0.45, 2.01);
let bore = cylinder([0, 0, 1.5], "Z", 1.0, 20.0) + cone(orifice / 2.0, 1.0, 1.0).translate([0, 0, 0.5]) + cylinder([0, 0, -1], "Z", orifice / 2.0, 2.0);
body - bore
