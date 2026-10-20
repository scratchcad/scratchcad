// Case front for a 12864 LCD controller: 150 x 60 mm board, 78 x 52 mm window, encoder hole 7 mm, 2 mm walls 15 mm deep
let board_w = 150.0; // [100.0, 200.0] Board width (mm)
let board_h = 60.0; // [40.0, 100.0] Board height (mm)
let depth = 15.0; // [8.0, 30.0] Depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let case_ = box(board_w + 2.0 * wall + 1.0, board_h + 2.0 * wall + 1.0, depth).fillet(4.0, "|Z").shell(-wall, "<Z");
case_ = case_ - box_from_corners([wall + 10.0, wall + 4.0, depth - 5], [wall + 10.0 + 78.0, wall + 4.0 + 52.0, depth + 5]);
case_ = case_ - cylinder([board_w - 25.0, board_h * 0.6, depth - 5], "Z", 3.5, 10.0);
case_ - cylinder([board_w - 25.0, board_h * 0.2, depth - 5], "Z", 2.5, 10.0)
