// Presser foot lifter lever: 4 mm thick, 12 mm pivot boss with a 4.1 mm pin hole, arm tapering from 8 to 10 mm over 45 mm to a 14 x 12 mm finger paddle with 3 mm rounded corners
let arm_len = 45.0; // [30.0, 65.0] Arm length (mm)
let thickness = 4.0; // [3.0, 6.0] Lever thickness (mm)
let paddle_w = 14.0; // [10.0, 20.0] Paddle width (mm)
let pin_d = 4.1; // [3.0, 5.0] Pivot hole (mm)
const boss_d = 12.0;
const paddle_l = 12.0;
let arm = polygon([[0, -4.0, 0], [arm_len, -5.0, 0], [arm_len, 5.0, 0], [0, 4.0, 0]]).to_face().extrude([0, 0, thickness]);
let paddle = box_from_corners([arm_len - 1.0, -paddle_w / 2.0, 0], [arm_len + paddle_l, paddle_w / 2.0, thickness]);
let paddle = paddle.fillet(3.0, paddle.edges("|Z"));
fuse_all([cylinder(boss_d / 2.0, thickness), arm, paddle]) - cylinder([0, 0, -1.0], "Z", pin_d / 2.0, thickness + 2.0)
