// Nozzle wipe brush holder for a 40 x 10 x 12 mm brass brush block: 46 x 16 x 10 mm cradle with a 40.4 x 10.4 mm pocket 8 mm deep, M3 set screw through the side, 30 mm mounting arm 4 mm thick with an M3 slot 10 mm long
let brush_l = 40.4; // [20.0, 60.0] Brush length (mm)
let brush_w = 10.4; // [6.0, 16.0] Brush width (mm)
let pocket = 8.0; // [5.0, 12.0] Pocket depth (mm)
let arm_l = 30.0; // [15.0, 60.0] Arm length (mm)
const wall = 3.0;
const floor_t = 2.0;
const arm_t = 4.0;
let cl = brush_l + 2.0 * wall;
let cw = brush_w + 2.0 * wall;
let ch = pocket + floor_t;
let cradle = box_from_corners([0, 0, 0], [cl, cw, ch]);
cradle = cradle.fillet(2.0, "|Z");
let arm = box_from_corners([cl - 0.5, 0, 0], [cl + arm_l, cw, arm_t]);
arm = arm.fillet(min(cw / 2.0 - 0.5, 5.0), arm.edges("|Z and >X"));
let holder = cradle + arm;
holder = holder - box_from_corners([wall, wall, floor_t], [cl - wall, cw - wall, ch + 1.0]);
let slot_len = min(10.0, arm_l - 10.0);
let x0 = cl + arm_l - 5.0 - slot_len;
holder = holder - fuse_all([cylinder([x0, cw / 2.0, -1], "Z", 1.7, arm_t + 2.0), cylinder([x0 + slot_len, cw / 2.0, -1], "Z", 1.7, arm_t + 2.0), box_from_corners([x0, cw / 2.0 - 1.7, -1], [x0 + slot_len, cw / 2.0 + 1.7, arm_t + 1.0])]);
holder - cylinder([cl / 2.0, -1, floor_t + pocket / 2.0], "Y", 1.4, wall + 2.0)
