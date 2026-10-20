// Seed starting insert, 6-cell: 2 x 3 cells 50 x 50 mm top, 38 mm bottom, 55 mm deep, 0.8 mm wall
let cell = 50.0; // [35.0, 70.0] Cell top size (mm)
let bottom = 38.0; // [25.0, 55.0] Cell bottom size (mm)
let depth = 55.0; // [35.0, 80.0] Depth (mm)
let wall = 0.8; // [0.5, 1.5] Wall (mm)
let cells = [];
let holes = [];
for i in 0..3 { for j in 0..2 {
    let x = (i.to_float() - 1.0) * cell;
    let y = (j.to_float() - 0.5) * cell;
    let outer = loft([rect(plane([x, y, 0], [0, 0, 1]), bottom, bottom), rect(plane([x, y, depth], [0, 0, 1]), cell, cell)], true);
    let inner = loft([rect(plane([x, y, wall], [0, 0, 1]), bottom - 2.0 * wall, bottom - 2.0 * wall), rect(plane([x, y, depth + 0.01], [0, 0, 1]), cell - 2.0 * wall, cell - 2.0 * wall)], true);
    cells.push(outer);
    holes.push(inner);
    holes.push(cylinder([x, y, -1], "Z", 3.0, wall + 2.0));
} }
let lip = box_centered(3.0 * cell + 6.0, 2.0 * cell + 6.0, 2.0).translate([0, 0, depth - 1.0]);
fuse_all(cells) + lip - compound(holes)
