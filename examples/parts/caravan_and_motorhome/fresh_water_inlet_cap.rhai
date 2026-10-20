// Caravan fresh water inlet cap: 50 mm cap 18 mm tall over a 42 mm inlet spigot with two 4 x 3 mm bayonet lugs, 12 grip ribs and a 3 mm lanyard tab
let spigot = 42.0; // [35.0, 55.0] Inlet spigot OD (mm)
let height = 18.0; // [12.0, 25.0] Cap height (mm)
const wall = 2.5;
let od = spigot + 2.0 * wall;
let cap = cylinder([0, 0, 0], "Z", od / 2.0, height) - cylinder([0, 0, -1.0], "Z", spigot / 2.0 + 0.3, height - wall + 1.0);
let lugs = box_from_corners([-spigot / 2.0 - 0.5, -2.0, 2.0], [-spigot / 2.0 + 2.5, 2.0, 5.0]) + box_from_corners([spigot / 2.0 - 2.5, -2.0, 2.0], [spigot / 2.0 + 0.5, 2.0, 5.0]);
let ribs = [];
for i in 0..12 { ribs.push(box_centered(1.6, 1.6, height - 2.0).translate([od / 2.0, 0, height / 2.0]).rotate_z(i.to_float() * 30.0 + 15.0)); }
let tab = box_from_corners([od / 2.0 - 1.0, -4.0, height - 3.0], [od / 2.0 + 10.0, 4.0, height]) - cylinder([od / 2.0 + 6.0, 0, height - 4.0], "Z", 2.0, 5.0);
cap + lugs + fuse_all(ribs) + tab
