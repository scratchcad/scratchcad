// DIN 71412 grease nipple M6 x 1, straight: 7 mm hex, 6.5 mm ball head, 15.5 mm overall
let thread_d = 6.0; // [6.0, 10.0] Thread (mm)
let hex = 7.0; // [7.0, 11.0] Hex (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let h = polygon(pts).to_face().extrude([0, 0, 3.0]);
let stud = cylinder([0, 0, -5.5], "Z", thread_d / 2.0, 5.51);
let neck = cylinder([0, 0, 2.99], "Z", 2.5, 4.0);
let ball = sphere([0, 0, 8.7], 3.25) & cylinder([0, 0, 6.0], "Z", 4.0, 4.2);
h + stud + neck + ball - cylinder([0, 0, -6.0], "Z", 1.0, 20.0)
