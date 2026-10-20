// A-frame wet floor sign top hinge knuckle (one of the pair): 60 mm wide socket block 20 mm tall with 2.5 mm cheeks and a 5.4 mm slot 17 mm deep that grips a 5 mm sign panel, and three 12 mm hinge knuckles 11.6 mm long along the top edge with a 5 mm pin bore, spaced for the mating half
let panel_t = 5.0; // [3.0, 8.0] Sign panel thickness (mm)
let width = 60.0; // [40.0, 100.0] Socket width (mm)
let socket_depth = 20.0; // [12.0, 35.0] Socket depth (mm)
let knuckles = 3; // [2, 5] Number of knuckles
const wall = 2.5;
const kd = 12.0;
let slot = panel_t + 0.4;
let st = slot + 2.0 * wall;
let socket = box_from_corners([-width / 2.0, -st / 2.0, 0], [width / 2.0, st / 2.0, socket_depth]);
let n = 2 * knuckles - 1;
let kl = width / n.to_float();
let parts = [socket];
for i in 0..knuckles {
    let x = -width / 2.0 + kl * (2 * i).to_float();
    parts.push(cylinder([x, 0, socket_depth + kd / 2.0 - 1.0], "X", kd / 2.0, kl - 0.4));
    parts.push(box_from_corners([x, -min(st, kd) / 2.0, socket_depth - 0.5], [x + kl - 0.4, min(st, kd) / 2.0, socket_depth + kd / 2.0 - 1.0]));
}
let body = fuse_all(parts);
body - box_from_corners([-width / 2.0 - 1.0, -slot / 2.0, -1.0], [width / 2.0 + 1.0, slot / 2.0, socket_depth - 3.0]) - cylinder([-width, 0, socket_depth + kd / 2.0 - 1.0], "X", 2.5, 2.0 * width)
