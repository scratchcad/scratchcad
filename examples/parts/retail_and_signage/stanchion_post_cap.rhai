// Queue barrier stanchion post top: fits a 63 mm tube, 70 mm dome, belt cassette slot 50 x 3 mm, 4 belt keyways
let tube = 63.0; // [50.0, 76.0] Post tube OD (mm)
let dome_h = 25.0; // [10.0, 40.0] Dome height (mm)
let rs = ((tube / 2.0 + 3.5) * (tube / 2.0 + 3.5) + dome_h * dome_h) / (2.0 * dome_h);
let dome = sphere([0, 0, dome_h - rs], rs) & cylinder(tube / 2.0 + 3.5, dome_h);
let spigot = cylinder([0, 0, -20.0], "Z", tube / 2.0 - 2.5, 20.01) - cylinder([0, 0, -21.0], "Z", tube / 2.0 - 5.0, 18.0);
let keyways = [];
for k in 0..4 { keyways.push(box_from_corners([tube / 2.0 - 6.0, -3.0, -15.0], [tube / 2.0, 3.0, 0.5]).rotate_z(k.to_float() * 90.0)); }
dome + spigot - fuse_all(keyways)
