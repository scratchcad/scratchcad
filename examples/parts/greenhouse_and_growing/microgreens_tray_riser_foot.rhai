// Microgreens tray riser foot: stacking corner foot that lifts a 1020 seed tray 25 mm off a capillary mat, 40 x 40 mm L-corner pocket for a 3 mm tray rim, 25 mm legs with 6 mm drainage gap, nests on the foot below
// # Corner
let size = 40.0; // [30.0, 60.0] Corner size (mm)
let lift = 25.0; // [10.0, 50.0] Lift height (mm)
let rim = 3.0; // [1.5, 5.0] Tray rim thickness (mm)
// # Detail
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
let pocket_depth = 10.0; // [6.0, 15.0] Rim pocket depth (mm)
let top = box_from_corners([0, 0, lift], [size, size, lift + pocket_depth + wall]);
let arm_x = box_from_corners([wall, wall, lift + wall], [size + 1.0, wall + rim, lift + pocket_depth + wall + 1.0]);
let arm_y = box_from_corners([wall, wall, lift + wall], [wall + rim, size + 1.0, lift + pocket_depth + wall + 1.0]);
let inner = box_from_corners([wall + rim + wall, wall + rim + wall, lift + wall], [size + 1.0, size + 1.0, lift + pocket_depth + wall + 1.0]);
let leg = box_from_corners([0, 0, 0], [size * 0.5, size * 0.5, lift + 0.01]);
let drain = box_from_corners([-1.0, size * 0.25 - 3.0, -1.0], [size * 0.5 + 1.0, size * 0.25 + 3.0, 4.0]);
let nest = box_from_corners([wall, wall, -1.0], [size * 0.5 - wall, size * 0.5 - wall, lift - wall]);
(top - arm_x - arm_y - inner) + (leg - drain - nest)
