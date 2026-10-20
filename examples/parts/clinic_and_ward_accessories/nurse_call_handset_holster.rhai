// Nurse call handset holster for the bed rail: pocket for a 48 x 32 mm pillow-speaker handset, 60 mm deep, 2.5 mm walls with 6 mm rounded corners, a 10 mm cable slot in the floor and a 40 mm strap loop for a 30 mm rail
let hand_w = 48.0; // [35.0, 65.0] Handset width (mm)
let hand_t = 32.0; // [20.0, 45.0] Handset thickness (mm)
let depth = 60.0; // [40.0, 90.0] Pocket depth (mm)
let rail = 30.0; // [20.0, 40.0] Bed rail size (mm)
const t = 2.5;
let outer = box_from_corners([-hand_w / 2.0 - t, -hand_t / 2.0 - t, 0], [hand_w / 2.0 + t, hand_t / 2.0 + t, depth]);
outer = outer.fillet(6.0, outer.edges("|Z"));
let p = outer - box_from_corners([-hand_w / 2.0, -hand_t / 2.0, t], [hand_w / 2.0, hand_t / 2.0, depth + 1.0]);
p = p - box_from_corners([-5.0, -hand_t / 2.0, -1.0], [5.0, hand_t / 2.0 + t + 1.0, t + 1.0]);
let loop_ = box_from_corners([-20.0, -hand_t / 2.0 - t - rail - 4.0, depth - 25.0], [20.0, -hand_t / 2.0 - t + 1.0, depth]);
loop_ = loop_ - box_from_corners([-21.0, -hand_t / 2.0 - t - rail, depth - 21.0], [21.0, -hand_t / 2.0 - t, depth + 1.0]);
p + loop_
