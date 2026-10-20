// Pneumatic exhaust silencer, G1/8: 9.7 mm thread 6 mm, 14 mm hex, 12 mm x 22 mm porous body with dome
let thread_d = 9.7; // [7.0, 21.0] Thread diameter (mm)
let hex = 14.0; // [10.0, 27.0] Hex (mm)
let body_d = 12.0; // [9.0, 25.0] Silencer diameter (mm)
let body_l = 22.0; // [12.0, 45.0] Silencer length (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let h = polygon(pts).to_face().extrude([0, 0, 5.0]);
let stud = cylinder([0, 0, -6.0], "Z", thread_d / 2.0, 6.01);
let body = cylinder([0, 0, 4.99], "Z", body_d / 2.0, body_l - body_d / 2.0) + sphere([0, 0, 4.99 + body_l - body_d / 2.0], body_d / 2.0);
let grooves = [];
for k in 0..5 { grooves.push(cylinder([0, 0, 7.0 + k.to_float() * 3.0], "Z", body_d, 0.8) - cylinder([0, 0, 6.0 + k.to_float() * 3.0], "Z", body_d / 2.0 - 0.4, 3.0)); }
h + stud + body - compound(grooves) - cylinder([0, 0, -7.0], "Z", 2.5, body_l)
