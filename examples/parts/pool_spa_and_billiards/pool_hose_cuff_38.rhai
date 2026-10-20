// 38 mm (1.5 in) pool hose swivel cuff: 38 mm bore, 45 mm long, 3 mm wall, 6 grip ribs, 40 mm skimmer spigot
let bore = 38.0; // [32.0, 50.0] Hose bore (mm)
let length = 45.0; // [30.0, 60.0] Cuff length (mm)
let wall = 3.0; // [2.0, 4.0] Wall (mm)
let cuff = cylinder(bore / 2.0 + wall, length) - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0);
let ribs = [];
for k in 0..6 { ribs.push(box_from_corners([bore / 2.0 + wall - 0.01, -1.5, 5.0], [bore / 2.0 + wall + 2.0, 1.5, length - 5.0]).rotate_z(k.to_float() * 60.0)); }
let spigot = cone(bore / 2.0 + 1.0, bore / 2.0 - 0.5, 30.0).translate([0, 0, length - 0.01]) - cylinder([0, 0, length - 1.0], "Z", bore / 2.0 - 3.0, 35.0);
cuff + fuse_all(ribs) + spigot
