// Hydraulic banjo bolt M10 x 1.0: 14 mm hex 6 mm, 20 mm shank, 5 mm axial bore, 3 mm cross hole, 6 mm under-head groove
let thread_d = 10.0; // [8.0, 16.0] Thread (mm)
let hex = 14.0; // [12.0, 24.0] Hex (mm)
let shank_l = 20.0; // [14.0, 35.0] Shank length (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let head = polygon(pts).to_face().extrude([0, 0, 6.0]) & cone(hex / 2.0 + 1.5, hex / 2.0 - 0.5, 6.0);
let shank = cylinder([0, 0, -shank_l], "Z", thread_d / 2.0, shank_l + 0.01);
let groove = cylinder([0, 0, -8.0], "Z", thread_d, 6.0) - cylinder([0, 0, -9.0], "Z", thread_d / 2.0 - 1.2, 8.0);
head + shank - groove - cylinder([0, 0, -shank_l - 1.0], "Z", 2.5, shank_l - 4.0) - cylinder([-thread_d, 0, -5.0], "X", 1.5, thread_d * 2.0)
