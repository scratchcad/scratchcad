// 15 mm end-feed copper end cap (EN 1254-1): 15.05 mm socket 11 mm deep, 0.9 mm wall, 2 mm closed end, 0.8 mm chamfered rim
let pipe = 15.0; // [8.0, 54.0] Pipe size (mm)
let socket_depth = 11.0; // [7.0, 30.0] Socket depth (mm)
let wall = 0.9; // [0.7, 2.0] Wall thickness (mm)
let end_t = 2.0; // [1.0, 4.0] End thickness (mm)
let ri = pipe / 2.0 + 0.025;
let ro = ri + wall;
let cap = cylinder(ro, socket_depth + end_t);
let cap = cap.chamfer(min(0.8, wall * 0.8), cap.edges(">Z"));
cap - cylinder([0, 0, -1], "Z", ri, socket_depth + 1.0)
