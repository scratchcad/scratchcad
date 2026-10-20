// 25 mm spade drill bit: 1/4 in hex shank 40 mm, 6 mm round shank 100 mm, 2.5 mm paddle with centre spur and two side spurs
let d = 25.0; // [10.0, 40.0] Cutting diameter (mm)
let rc = 6.35 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(hp).to_face().extrude(40.0).translate([0, 0, 100.0]);
let shank = cylinder(3.0, 100.5);
let paddle = polygon([[-d / 2.0, 0, 0], [-d / 2.0, 0, -22.0], [-d / 2.0 + 2.0, 0, -25.0], [-3.0, 0, -22.0], [0, 0, -32.0], [3.0, 0, -22.0], [d / 2.0 - 2.0, 0, -25.0], [d / 2.0, 0, -22.0], [d / 2.0, 0, 0], [3.0, 0, 6.0], [-3.0, 0, 6.0]]).to_face().extrude([0, 2.5, 0]).translate([0, -1.25, 0]);
fuse_all([paddle, shank, hex]) - cylinder([0, -2, -10.0], "Y", 2.0, 4.0)
