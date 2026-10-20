// PC/104 stack standoff: 15.24 mm board spacing, 6 mm hex, M3 female/male with 6 mm stud
let spacing = 15.24; // [11.0, 25.0] Board spacing (mm)
let hex = 6.0; // [5.0, 8.0] Hex across flats (mm)
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let body = polygon(pts).to_face().extrude([0, 0, spacing]);
body + cylinder([0, 0, spacing - 0.01], "Z", 1.5, 6.0) - cylinder([0, 0, -1], "Z", 1.25, 7.0)
