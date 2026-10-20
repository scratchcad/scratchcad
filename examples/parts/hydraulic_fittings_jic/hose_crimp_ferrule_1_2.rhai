// 1/2 inch two-wire hose crimp ferrule: 27 mm OD 45 mm long, 2.5 mm wall, with internal grip ridges (6 at 45 mm long) 0.6 mm on 6 mm pitch and a 21.8 mm inturned lip at the fitting end
let od = 27.0; // [20.0, 36.0] Ferrule OD (mm)
let length = 45.0; // [30.0, 60.0] Ferrule length (mm)
const wall = 2.5;
let r = od / 2.0;
let f = cylinder([0, 0, 0], "Z", r, length) - cylinder([0, 0, -1.0], "Z", r - wall, length + 2.0);
let lip = cylinder([0, 0, 0], "Z", r - wall + 0.01, 3.0) - cylinder([0, 0, -1.0], "Z", r - wall - 1.6, 5.0);
let ridges = [];
let n = ((length - 12.0) / 6.0).to_int();
for i in 0..n { ridges.push(cylinder([0, 0, 8.0 + i.to_float() * 6.0], "Z", r - wall + 0.01, 1.5) - cylinder([0, 0, 7.0 + i.to_float() * 6.0], "Z", r - wall - 0.6, 3.5)); }
f + lip + fuse_all(ridges)
