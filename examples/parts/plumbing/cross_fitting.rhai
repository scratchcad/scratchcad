// 4-way cross for 25 mm tube: 32 mm body, 25.2 mm sockets 20 mm deep, 70 mm across
let tube = 25.2; // [10.0, 60.0] Tube OD (mm)
let socket_depth = 20.0; // [10.0, 40.0] Socket depth (mm)
let wall = 3.0; // [2.0, 6.0] Wall (mm)
let span = 2.0 * socket_depth + tube + 2.0 * wall;
let ro = tube / 2.0 + wall;
let body = cylinder([-span / 2.0, 0, 0], "X", ro, span) + cylinder([0, -span / 2.0, 0], "Y", ro, span);
let bores = cylinder([-span, 0, 0], "X", tube / 2.0 - wall, span * 2.0) + cylinder([0, -span, 0], "Y", tube / 2.0 - wall, span * 2.0);
let sockets = [];
for i in 0..4 { sockets.push(cylinder([span / 2.0 - socket_depth, 0, 0], "X", tube / 2.0, socket_depth + 1.0).rotate_z(i * 90)); }
body - bores - fuse_all(sockets)
