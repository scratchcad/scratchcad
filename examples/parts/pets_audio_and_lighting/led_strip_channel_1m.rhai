// Aluminium LED strip channel: 17 x 8 mm U profile 200 mm long, 1.2 mm walls, 12 mm strip seat, clip-in diffuser grooves
let len = 200.0; // [50.0, 1000.0] Length (mm)
let p = polygon([[-8.5, 0], [8.5, 0], [8.5, 8.0], [7.3, 8.0], [7.3, 1.2], [-7.3, 1.2], [-7.3, 8.0], [-8.5, 8.0]]);
let profile = p.to_face().extrude(len);
let grooves = [];
for s in [-1.0, 1.0] { grooves.push(box_centered(0.8, 0.6, len + 2.0).translate([s * 7.3, 6.8, len / 2.0])); }
(profile - fuse_all(grooves)).rotate_x(-90.0)
