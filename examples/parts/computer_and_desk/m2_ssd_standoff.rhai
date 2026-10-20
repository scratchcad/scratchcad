// M.2 SSD standoff: 5 mm hex 3.6 mm tall with M2 thread hole, M2 x 3 mm male stud below
let hex = 5.0; // [4.0, 7.0] Hex across flats (mm)
let height = 3.6; // [2.0, 6.0] Height (mm)
let stud = 3.0; // [2.0, 5.0] Stud length (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let body = polygon(pts).to_face().extrude([0, 0, height]);
let s = cylinder([0, 0, -stud], "Z", 1.0, stud + 0.01);
body + s - cylinder([0, 0, 0.6], "Z", 0.8, height)
