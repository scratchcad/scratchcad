// Cutlery tray: 300 x 380 x 50 mm, 5 compartments (2 long 55 mm, 3 narrow 80 mm) 2.5 mm walls
let width = 300.0; // [250.0, 400.0] Tray width (mm)
let depth = 380.0; // [300.0, 500.0] Tray depth (mm)
let height = 50.0; // [40.0, 70.0] Height (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let tray = box_from_corners([0, 0, 0], [width, depth, height]);
let cells = [];
let x0 = [wall, wall + 80.0 + wall, wall + 2.0 * wall + 135.0, wall + 3.0 * wall + 190.0];
let x1 = [wall + 80.0, wall + 80.0 + wall + 55.0, wall + 2.0 * wall + 190.0, width - wall];
for i in 0..4 { cells.push(box_from_corners([x0[i], wall, wall], [x1[i], depth - wall, height + 1.0])); }
let c = fuse_all(cells);
tray - c.fillet(5.0, c.edges("|Z"))
