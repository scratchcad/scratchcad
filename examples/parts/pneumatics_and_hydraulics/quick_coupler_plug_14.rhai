// 1/4 in industrial (Milton M-style) air coupler plug: 1/4 NPT male, 14.3 mm hex, 9.4 mm nose with locking groove
let nose_d = 9.4; // [8.0, 12.0] Nose diameter (mm)
let hex = 14.3; // [12.0, 20.0] Hex (mm)
let thread_d = 13.7; // [10.0, 17.0] NPT diameter (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let h = polygon(pts).to_face().extrude([0, 0, 6.5]);
let npt = cone(thread_d / 2.0 - 0.3, thread_d / 2.0, 10.0).translate([0, 0, -10.0]);
let nose = cylinder([0, 0, 6.49], "Z", nose_d / 2.0, 16.0);
let groove = cylinder([0, 0, 13.0], "Z", nose_d, 2.5) - cylinder([0, 0, 12.0], "Z", nose_d / 2.0 - 1.0, 5.0);
let tip = nose.chamfer(1.0, nose.edges(">Z"));
h + npt + tip - groove - cylinder([0, 0, -11.0], "Z", 2.8, 35.0)
