// 6-cell seedling pack (2 x 3): 57 mm cell pitch, cells 54 mm square at the top tapering to 40 mm, 55 mm deep, 0.8 mm wall, drain hole each
let rows = 2; // [1, 4] Rows of cells
let columns = 3; // [1, 6] Columns of cells
let cell_top = 54.0; // [35.0, 70.0] Cell width at the top (mm)
let cell_bottom = 40.0; // [25.0, 60.0] Cell width at the bottom (mm)
let depth = 55.0; // [30.0, 80.0] Cell depth (mm)
let wall = 0.8; // [0.6, 2.0] Wall thickness (mm)
let pitch = cell_top + 3.0;
let bottom = min(cell_bottom, cell_top);
let outers = [];
let inners = [];
let holes = [];
for r in 0..rows {
    for c in 0..columns {
        let x = (c.to_float() - (columns - 1).to_float() / 2.0) * pitch;
        let y = (r.to_float() - (rows - 1).to_float() / 2.0) * pitch;
        outers.push(loft([rect(plane([x, y, 0], "Z"), bottom + 2.0 * wall, bottom + 2.0 * wall),
                          rect(plane([x, y, depth], "Z"), cell_top + 2.0 * wall, cell_top + 2.0 * wall)], true));
        inners.push(loft([rect(plane([x, y, wall], "Z"), bottom, bottom),
                          rect(plane([x, y, depth + 2.0], "Z"), cell_top + (cell_top - bottom) * 2.0 / (depth - wall), cell_top + (cell_top - bottom) * 2.0 / (depth - wall))], true));
        holes.push(cylinder([x, y, -1.0], "Z", 5.0, wall + 2.0));
    }
}
let rim = box_centered(columns.to_float() * pitch + 6.0, rows.to_float() * pitch + 6.0, 2.0).translate([0, 0, depth - 1.0]);
let tray = fuse_all(outers + [rim]);
tray - fuse_all(inners + holes)
