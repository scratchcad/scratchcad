// Cash till coin tray: 8 scooped compartments in a 330 x 120 x 35 mm tray, 2 mm walls
let length = 330.0; // [250.0, 420.0] Length (mm)
let width = 120.0; // [90.0, 150.0] Width (mm)
let depth = 35.0; // [25.0, 50.0] Depth (mm)
let n = 8; // [4, 10] Compartment count
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let tray = box_from_corners([0, 0, 0], [length, width, depth]);
let cells = [];
let cw = (length - wall) / n.to_float();
for i in 0..n {
    let x0 = wall + i.to_float() * cw;
    let cell = box_from_corners([x0, wall, wall], [x0 + cw - wall, width - wall, depth + 1.0]);
    cells.push(cell);
}
let c = fuse_all(cells);
tray - c.fillet(8.0, c.edges("|X and <Z and <Y"))
