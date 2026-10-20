// PVC DWV tee for 50 mm pipe: 50.2 mm sockets 25 mm deep, 3.2 mm walls, 140 mm run
let pipe_od = 50.2; // [20.0, 160.0] Pipe OD (mm)
let socket_depth = 25.0; // [15.0, 60.0] Socket depth (mm)
let wall = 3.2; // [2.0, 8.0] Wall (mm)
let run = 2.0 * socket_depth + pipe_od + 2.0 * wall;
let ro = pipe_od / 2.0 + wall;
let body = cylinder([-run / 2.0, 0, 0], "X", ro, run) + cylinder([0, 0, 0], "Z", ro, run / 2.0);
let sockets = cylinder([-run / 2.0 - 1.0, 0, 0], "X", pipe_od / 2.0, socket_depth + 1.0) + cylinder([run / 2.0 - socket_depth, 0, 0], "X", pipe_od / 2.0, socket_depth + 1.0) + cylinder([0, 0, run / 2.0 - socket_depth], "Z", pipe_od / 2.0, socket_depth + 1.0);
let bore = cylinder([-run, 0, 0], "X", pipe_od / 2.0 - wall, run * 2.0) + cylinder([0, 0, 0], "Z", pipe_od / 2.0 - wall, run);
body - sockets - bore
