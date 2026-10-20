// SMA female edge-mount connector: 1/4-36 thread 6.35 mm x 8 mm, 6.35 mm hex flange, PTFE insulator, 1.27 mm pin
let thread_d = 6.35; // [6.0, 7.0] Thread diameter (mm)
let thread_l = 8.0; // [5.0, 12.0] Thread length (mm)
let hex = 8.0; // [7.0, 10.0] Hex flange (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let body = cylinder(thread_d / 2.0, thread_l) + polygon(pts).to_face().extrude(2.0).translate([0, 0, -2.0]) + box_centered(6.35, 6.35, 1.6).translate([0, 0, -2.8]);
body = body - cylinder([0, 0, 1.0], "Z", 2.25, thread_l);
let insulator = cylinder([0, 0, 1.0], "Z", 2.0, thread_l - 1.5) - cylinder([0, 0, 0], "Z", 0.65, thread_l);
let pin = cylinder([0, 0, -5.0], "Z", 0.635, thread_l + 3.0);
[body, insulator, pin]
