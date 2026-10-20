// Rockwool cube holder: floating raft grid for 25 mm rockwool starter cubes, 4 x 6 cells at 32 mm pitch, 26 mm square through-holes with 2 mm support ledges, 15 mm deep frame with 3 mm walls
// # Grid
let cols = 6; // [2, 10] Number of columns
let rows = 4; // [2, 8] Number of rows
let pitch = 32.0; // [28.0, 45.0] Cell pitch (mm)
// # Cells
let cube = 25.0; // [20.0, 40.0] Rockwool cube size (mm)
let depth = 15.0; // [8.0, 25.0] Frame depth (mm)
let ledge = 2.0; // [1.0, 4.0] Support ledge width (mm)
let L = cols.to_float() * pitch + 6.0;
let W = rows.to_float() * pitch + 6.0;
let cell = min(cube + 1.0, pitch - 3.0);
let frame = box_centered(L, W, depth).translate([0, 0, depth / 2.0]).fillet(4.0, "|Z");
let pockets = [];
let throughs = [];
for i in 0..cols {
    for j in 0..rows {
        let x = (i.to_float() - (cols - 1).to_float() / 2.0) * pitch;
        let y = (j.to_float() - (rows - 1).to_float() / 2.0) * pitch;
        pockets.push(box_centered(cell, cell, depth).translate([x, y, depth / 2.0 + 2.0]));
        throughs.push(box_centered(cell - 2.0 * ledge, cell - 2.0 * ledge, depth).translate([x, y, 0]));
    }
}
frame - compound(pockets) - compound(throughs)
