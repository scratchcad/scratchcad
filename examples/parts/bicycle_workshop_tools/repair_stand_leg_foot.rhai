// Repair stand tripod leg foot: rubber cup for a 25.4 mm leg tube, 32.6 mm outside, 25 mm deep socket, 8 mm thick sole with a 1.5 mm bottom chamfer and a 1 mm lead-in at the mouth
let tube_d = 25.4; // [19.0, 32.0] Leg tube diameter (mm)
let wall = 3.6; // [2.5, 5.0] Wall thickness (mm)
let socket_depth = 25.0; // [15.0, 40.0] Socket depth (mm)
let sole = 8.0; // [5.0, 12.0] Sole thickness (mm)
let ri = tube_d / 2.0;
let ro = ri + wall;
let h = sole + socket_depth;
let profile = polygon([
    [0, 0, 0], [ro - 1.5, 0, 0], [ro, 0, 1.5], [ro, 0, h], [ri + 1.0, 0, h], [ri, 0, h - 1.0], [ri, 0, sole], [0, 0, sole]
]);
profile.to_face().revolve("Z", 360.0)
