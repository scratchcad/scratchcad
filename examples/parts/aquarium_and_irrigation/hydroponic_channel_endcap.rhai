// NFT hydroponic channel end cap for 100 x 50 mm channel: 2 mm sleeve 15 mm deep, 16 mm drain spigot
let width = 100.0; // [60.0, 150.0] Channel width (mm)
let height = 50.0; // [35.0, 80.0] Channel height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let sleeve = 15.0; // [10.0, 25.0] Sleeve depth (mm)
let outer = box_from_corners([-width / 2.0 - wall - 0.2, -height / 2.0 - wall - 0.2, 0], [width / 2.0 + wall + 0.2, height / 2.0 + wall + 0.2, sleeve + wall]);
let cap = outer - box_from_corners([-width / 2.0 - 0.2, -height / 2.0 - 0.2, wall], [width / 2.0 + 0.2, height / 2.0 + 0.2, sleeve + wall + 1.0]);
let spigot = cylinder([0, -height / 2.0 + 10.0, -12.0], "Z", 8.0, 12.01) - cylinder([0, -height / 2.0 + 10.0, -13.0], "Z", 6.0, 20.0);
cap + spigot - cylinder([0, -height / 2.0 + 10.0, -1], "Z", 6.0, wall + 2.0)
