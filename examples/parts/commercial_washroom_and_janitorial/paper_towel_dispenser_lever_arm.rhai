// Lever-feed paper towel dispenser lever arm: 6 mm thick arm 120 mm long from a 24 mm pivot boss 14 mm wide with an 8 mm square drive hole, tapering from 20 mm to 14 mm wide, ending in a 50 x 30 mm push paddle 4 mm thick with 8 mm rounded corners
let arm_len = 120.0; // [80.0, 180.0] Arm length (mm)
let paddle_w = 50.0; // [30.0, 80.0] Paddle width (mm)
let paddle_h = 30.0; // [20.0, 50.0] Paddle height (mm)
let drive = 8.0; // [6.0, 12.0] Square drive size (mm)
const t = 6.0;
const boss_d = 24.0;
const boss_w = 14.0;
let br = max(boss_d / 2.0, drive * 0.71 + 4.0);
let boss = cylinder([0, -boss_w / 2.0, 0], "Y", br, boss_w);
let arm = face(polygon([[0, -t / 2.0, -10.0], [arm_len, -t / 2.0, -7.0], [arm_len, -t / 2.0, 7.0], [0, -t / 2.0, 10.0]])).extrude([0, t, 0]);
let pad = box_from_corners([arm_len - 4.0, -paddle_w / 2.0, -paddle_h / 2.0], [arm_len, paddle_w / 2.0, paddle_h / 2.0]);
let pad = pad.fillet(min(8.0, paddle_h / 2.0 - 1.0), pad.edges("|X"));
let body = fuse_all([boss, arm, pad]);
body - box_centered(drive, boss_w + 2.0, drive)
