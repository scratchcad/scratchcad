// Sandpit cover corner: 90 degree corner cap for 100 x 22 mm sandpit boards, 3 mm walls, 60 mm legs, top 30 mm overlap and a 20 mm drain notch
let board_t = 22.0; // [15.0, 35.0] Board thickness (mm)
let leg = 60.0; // [40.0, 90.0] Leg length (mm)
const wall = 3.0;
let o = board_t + 2.0 * wall;
let top = box_from_corners([-wall, -wall, 0], [leg, o - wall, wall]) + box_from_corners([-wall, -wall, 0], [o - wall, leg, wall]);
let skirts = box_from_corners([-wall, -wall, -30.0], [leg, 0, 0.01]) + box_from_corners([-wall, -wall, -30.0], [0, leg, 0.01]) + box_from_corners([-wall, board_t, -30.0], [leg, board_t + wall, 0.01]) + box_from_corners([board_t, board_t, -30.0], [board_t + wall, leg, 0.01]);
top + skirts - box_from_corners([leg - 20.0, -wall - 1.0, -31.0], [leg - 10.0, board_t + wall + 1.0, -25.0])
