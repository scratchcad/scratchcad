// Trellis net clip: snap clip that fastens 2 mm trellis netting cord to a 16 mm garden cane or stake, 15 mm wide, C-ring with 2.2 mm wall and 11 mm mouth, cord hook with a 2.2 mm keeper slot
// # Stake
let stake = 16.0; // [8.0, 25.0] Stake diameter (mm)
let width = 15.0; // [8.0, 25.0] Clip width (mm)
let wall = 2.2; // [1.5, 3.5] Wall thickness (mm)
// # Cord
let cord = 2.2; // [1.5, 4.0] Cord diameter (mm)
let hook_reach = 10.0; // [6.0, 18.0] Hook reach (mm)
let r = stake / 2.0;
let ro = r + wall;
let ring = cylinder(ro, width) - cylinder([0, 0, -1.0], "Z", r, width + 2.0);
let mouth_w = stake * 0.7;
let mouth = box_from_corners([-mouth_w / 2.0, 0, -1.0], [mouth_w / 2.0, ro + 1.0, width + 1.0]);
let arm = box_from_corners([-wall, -ro - hook_reach, 0], [wall, -r - 0.5, width]);
let head = box_from_corners([-wall - cord - 3.0, -ro - hook_reach - wall, 0], [wall, -ro - hook_reach + 0.01, width]);
let hook_tip = box_from_corners([-wall - cord - 3.0, -ro - hook_reach - wall + 0.01, 0], [-wall - cord, -ro - hook_reach + cord + 2.0, width]);
let keeper = cylinder([-wall - cord / 2.0 - 0.01, -ro - hook_reach + cord / 2.0 + 0.2, -1.0], "Z", cord / 2.0 + 0.1, width + 2.0);
(ring - mouth) + arm + head + hook_tip - keeper
