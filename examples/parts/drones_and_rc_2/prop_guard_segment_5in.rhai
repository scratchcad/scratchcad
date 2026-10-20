// 5 in prop guard ring segment: 135 mm inner diameter arc of 60 degrees, 10 mm tall 2 mm wall, 2 arm tabs 12 mm with M3 holes
let id = 135.0; // [110.0, 180.0] Guard inner diameter (mm)
let height = 10.0; // [6.0, 15.0] Guard height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let ring = cylinder(id / 2.0 + wall, height) - cylinder([0, 0, -1], "Z", id / 2.0, height + 2.0);
let sector = polygon([[0, 0], [id, 0], [id * 0.5, id * 0.866]]).to_face().extrude([0, 0, height + 2.0]).translate([0, 0, -1.0]);
let arc = ring & sector;
let tabs = [];
for a in [15.0, 45.0] { tabs.push((box_from_corners([id / 2.0 - 12.0, -5.0, 0], [id / 2.0 + 0.5, 5.0, 3.0]) - cylinder([id / 2.0 - 7.0, 0, -1], "Z", 1.6, 5.0)).rotate_z(a)); }
arc + fuse_all(tabs)
