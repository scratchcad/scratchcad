// Raised bed corner bracket: holds two 150 x 25 mm boards at 90 degrees, 150 mm tall, 3 mm walls and floor, 8 screw holes
let board_h = 150.0; // [100.0, 300.0] Board height (mm)
let board_t = 25.0; // [18.0, 50.0] Board thickness (mm)
let leg = 60.0; // [40.0, 100.0] Bracket leg length (mm)
let t = 3.0; // [2.0, 5.0] Wall (mm)
let outer = box_from_corners([-t, -t, 0], [leg, board_t + t, board_h]) + box_from_corners([-t, -t, 0], [board_t + t, leg, board_h]);
let inner = box_from_corners([0, 0, -1], [leg + 1.0, board_t, board_h + 1.0]) + box_from_corners([0, 0, -1], [board_t, leg + 1.0, board_h + 1.0]);
let holes = [];
for z in [board_h * 0.25, board_h * 0.75] { for x in [board_t + 12.0, leg - 10.0] { holes.push(cylinder([x, -t - 1.0, z], "Y", 2.25, t + 2.0)); holes.push(cylinder([-t - 1.0, x, z], "X", 2.25, t + 2.0)); } }
let floor = box_from_corners([-t, -t, -t], [leg, board_t + t, 0.01]) + box_from_corners([-t, -t, -t], [board_t + t, leg, 0.01]);
outer + floor - inner - compound(holes)
