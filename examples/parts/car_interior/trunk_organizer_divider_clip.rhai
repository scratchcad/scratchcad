// Trunk organizer divider joint clip: cross slot for 4 mm boards, 40 x 40 x 30 mm, 2 mm walls
let board = 4.0; // [3.0, 8.0] Board thickness (mm)
let size = 40.0; // [30.0, 60.0] Clip size (mm)
let height = 30.0; // [20.0, 40.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let a = box_centered(size, board + 2.0 * wall, height) + box_centered(board + 2.0 * wall, size, height);
a - box_centered(size + 2.0, board + 0.3, height - 2.0 * wall + 1.0).translate([0, 0, wall]) - box_centered(board + 0.3, size + 2.0, height - 2.0 * wall + 1.0).translate([0, 0, wall])
