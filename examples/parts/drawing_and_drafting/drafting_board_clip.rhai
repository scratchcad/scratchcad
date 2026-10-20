// Drafting board paper clip: clamps 18 mm board, 40 mm wide, 3 mm spring-steel style C with lip
let board = 18.0; // [10.0, 30.0] Board thickness (mm)
let width = 40.0; // [20.0, 60.0] Clip width (mm)
let t = 3.0; // [2.0, 5.0] Wall thickness (mm)
let reach = 25.0; // [15.0, 40.0] Jaw reach (mm)
let c = box_from_corners([0, 0, 0], [reach + t, width, board + 2.0 * t]) - box_from_corners([t, -1, t], [reach + t + 1.0, width + 1.0, board + t - 0.6]);
let lip = box_from_corners([reach + t - 4.0, 0, board + t - 1.6], [reach + t, width, board + t + 0.01]);
c + lip
