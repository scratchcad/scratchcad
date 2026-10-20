// Waterfall spillway lip: 300 mm wide weir, 150 mm deep tray with 40 mm side and back walls, 3 mm thick, ending in a 10 mm drip lip, and a 44 mm inlet spigot 40 mm long through the back wall
let width = 300.0; // [150.0, 600.0] Spillway width (mm)
let depth = 150.0; // [100.0, 250.0] Tray depth (mm)
const t = 3.0;
let tray = box_from_corners([0, 0, 0], [width, depth, 40.0]) - box_from_corners([t, t, t], [width - t, depth + 1.0, 41.0]);
let lip = box_from_corners([0, depth - t, -10.0], [width, depth, t]);
let spig = cylinder([width / 2.0, -40.0, 21.0], "Y", 22.0, 40.01) - cylinder([width / 2.0, -41.0, 21.0], "Y", 19.0, 45.0);
tray + lip + spig - cylinder([width / 2.0, -1.0, 21.0], "Y", 19.0, t + 2.0)
