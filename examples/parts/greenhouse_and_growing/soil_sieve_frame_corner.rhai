// Soil sieve frame corner: corner block joining 44 x 19 mm timber sides of a garden riddle, two 45 mm deep sockets at 90 degrees with 2.5 mm wall, 6 mm mesh ledge 3 mm high inside and 4 mm screw holes in each socket
// # Timber
let timber_w = 44.0; // [30.0, 70.0] Timber width (mm)
let timber_t = 19.0; // [12.0, 25.0] Timber thickness (mm)
let socket_depth = 45.0; // [25.0, 70.0] Socket depth (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
// # Mesh
let ledge = 6.0; // [3.0, 10.0] Mesh ledge width (mm)
let screw = 4.0; // [3.0, 5.0] Screw hole diameter (mm)
let L = socket_depth + timber_t + 2.0 * wall;
let h = timber_w + 2.0 * wall;
let tw = timber_t + 2.0 * wall;
let arm_x = box_from_corners([0, 0, 0], [L, tw, h]);
let arm_y = box_from_corners([0, 0, 0], [tw, L, h]);
let block = arm_x + arm_y;
let sock_x = box_from_corners([tw, wall, wall], [L + 1.0, wall + timber_t, wall + timber_w]);
let sock_y = box_from_corners([wall, tw, wall], [wall + timber_t, L + 1.0, wall + timber_w]);
let stop = box_from_corners([wall, wall, wall], [tw - 0.01, tw - 0.01, wall + timber_w]);
let ledge_x = box_from_corners([tw, tw - 0.01, 0], [L, tw + ledge, wall + 3.0]);
let ledge_y = box_from_corners([tw - 0.01, tw - 0.01, 0], [tw + ledge, L, wall + 3.0]);
let holes = [cylinder([tw + socket_depth / 2.0, -1.0, h / 2.0], "Y", screw / 2.0, tw + 2.0), cylinder([-1.0, tw + socket_depth / 2.0, h / 2.0], "X", screw / 2.0, tw + 2.0)];
(block - sock_x - sock_y + stop + ledge_x + ledge_y) - compound(holes)
