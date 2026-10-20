// Seed sowing dibble board: 200 x 150 mm press board that marks a 4 x 3 grid of 12 mm deep sowing holes at 50 mm spacing, 6 mm board, 10 mm diameter conical pegs, central 30 mm D-handle
// # Board
let length = 200.0; // [120.0, 300.0] Board length (mm)
let width = 150.0; // [100.0, 220.0] Board width (mm)
let board_t = 6.0; // [4.0, 10.0] Board thickness (mm)
// # Pegs
let cols = 4; // [2, 6] Number of peg columns
let rows = 3; // [2, 5] Number of peg rows
let spacing = 50.0; // [25.0, 75.0] Peg spacing (mm)
let peg_depth = 12.0; // [5.0, 25.0] Sowing depth (mm)
let peg_d = 10.0; // [5.0, 15.0] Peg diameter (mm)
let board = box_centered(length, width, board_t).translate([0, 0, board_t / 2.0]).fillet(8.0, "|Z");
let pegs = [];
for i in 0..cols {
    for j in 0..rows {
        let x = (i.to_float() - (cols - 1).to_float() / 2.0) * spacing;
        let y = (j.to_float() - (rows - 1).to_float() / 2.0) * spacing;
        pegs.push(cone(1.5, peg_d / 2.0, peg_depth).translate([x, y, -peg_depth + 0.01]));
    }
}
let handle = box_from_corners([-40.0, -6.0, board_t - 0.01], [40.0, 6.0, board_t + 32.0]).fillet(10.0, "|Y and >Z") - box_from_corners([-30.0, -7.0, board_t + 0.01], [30.0, 7.0, board_t + 22.0]).fillet(6.0, "|Y and >Z");
board + compound(pegs) + handle
