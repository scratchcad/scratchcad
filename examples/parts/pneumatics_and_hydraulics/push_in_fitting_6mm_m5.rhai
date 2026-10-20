// Push-in pneumatic fitting, straight, 6 mm tube to M5 male: 12 mm hex 4 mm, 11 mm body 14 mm, release collet 10 mm
let tube = 6.0; // [4.0, 12.0] Tube OD (mm)
let body_d = 11.0; // [8.0, 20.0] Body diameter (mm)
let hex = 12.0; // [8.0, 22.0] Hex across flats (mm)
let thread_d = 5.0; // [4.0, 12.0] Thread major diameter (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let h = polygon(pts).to_face().extrude([0, 0, 4.0]);
let hc = h & (cone(hex / 2.0 + 1.0, hex / 2.0 - 0.5, 4.0));
let stud = cylinder([0, 0, -5.0], "Z", thread_d / 2.0, 5.01);
let body = cylinder([0, 0, 3.99], "Z", body_d / 2.0, 14.0);
let collet = cylinder([0, 0, 17.98], "Z", body_d / 2.0 - 0.5, 2.0) + cylinder([0, 0, 19.97], "Z", body_d / 2.0 + 0.5, 1.5);
hc + stud + body + collet - cylinder([0, 0, 6.0], "Z", tube / 2.0, 20.0) - cylinder([0, 0, -6.0], "Z", 1.25, 14.0)
