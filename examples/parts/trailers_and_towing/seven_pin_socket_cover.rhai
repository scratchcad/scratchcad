// 7-pin trailer socket cover: 58 mm round flip lid 4 mm thick with a 45 mm sealing spigot 6 mm deep, a 6 mm hinge knuckle bored 3 mm and a 10 mm lift tab
let lid = 58.0; // [50.0, 70.0] Lid diameter (mm)
let spigot = 45.0; // [38.0, 52.0] Spigot diameter (mm)
const t = 4.0;
let l = cylinder([0, 0, 0], "Z", lid / 2.0, t);
let sp = cylinder([0, 0, -6.0], "Z", spigot / 2.0, 6.01) - cylinder([0, 0, -7.0], "Z", spigot / 2.0 - 2.0, 7.0);
let knuckle = cylinder([-10.0, lid / 2.0 + 2.0, 3.0], "X", 3.0, 20.0) + box_from_corners([-10.0, lid / 2.0 - 4.0, 0], [10.0, lid / 2.0 + 2.0, t]);
let tab = box_from_corners([-6.0, -lid / 2.0 - 10.0, 0], [6.0, -lid / 2.0 + 2.0, 2.0]);
l + sp + knuckle + tab - cylinder([-11.0, lid / 2.0 + 2.0, 3.0], "X", 1.5, 22.0)
