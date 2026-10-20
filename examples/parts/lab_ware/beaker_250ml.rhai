// 250 ml low-form glass beaker: 70 mm OD, 95 mm tall, 1.5 mm wall, beaded rim and a pouring spout
let od = 70.0; // [30.0, 120.0] Outer diameter (mm)
let h = 95.0; // [40.0, 180.0] Height (mm)
let r = od / 2.0;
let wall = [[0, 0, 0], [r - 3.0, 0, 0], [r, 0, 3.0], [r, 0, h - 2.0], [r + 1.5, 0, h - 1.0], [r + 1.5, 0, h + 2.0], [r - 1.5, 0, h + 2.0], [r - 1.5, 0, 4.0], [r - 4.0, 0, 1.5], [0, 0, 1.5]];
let beaker = polygon(wall).to_face().revolve("Z", 360);
let spout = polygon([[r - 3.0, 0, h - 8.0], [r + 5.0, 0, h + 3.0], [r - 3.0, 0, h + 3.0]]).to_face().extrude([0, 8.0, 0]).translate([0, -4.0, 0]);
beaker - (spout & cylinder([0, 0, h - 9.0], "Z", r - 1.4, 13.0)) + ((spout - cylinder([0, 0, h - 9.0], "Z", r - 1.4, 13.0)) - polygon([[r - 3.0, 0, h - 6.5], [r + 5.0, 0, h + 4.5], [r - 3.0, 0, h + 4.5]]).to_face().extrude([0, 5.0, 0]).translate([0, -2.5, 0]))
