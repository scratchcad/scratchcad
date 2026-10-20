// Cleaning trolley spray bottle holder: 4 mm thick ring 15 mm tall with an 85 mm bore for a 750 ml trigger spray bottle, a 3 mm floor ring with a 60 mm drain hole, and a 50 mm wide hook plate 4 mm thick that drops over a 6 mm trolley edge rail
let bottle_d = 85.0; // [60.0, 110.0] Bottle diameter (mm)
let ring_h = 15.0; // [10.0, 30.0] Ring height (mm)
let rail_t = 6.0; // [3.0, 12.0] Trolley rail thickness (mm)
let hook_depth = 30.0; // [15.0, 50.0] Hook drop (mm)
const wall = 4.0;
const floor_t = 3.0;
const hw = 50.0;
let ri = bottle_d / 2.0 + 0.5;
let ro = ri + wall;
let ring = cylinder([0, 0, 0], "Z", ro, ring_h) - cylinder([0, 0, floor_t], "Z", ri, ring_h);
let ring = ring - cylinder([0, 0, -1.0], "Z", min(30.0, ri - 8.0), floor_t + 2.0);
let y0 = -ro + 1.0;
let back = box_from_corners([-hw / 2.0, y0 - wall, 0], [hw / 2.0, y0 + 0.5, ring_h + 10.0]);
let top = box_from_corners([-hw / 2.0, y0 - wall - rail_t - wall, ring_h + 10.0 - wall], [hw / 2.0, y0 - wall + 0.5, ring_h + 10.0]);
let drop = box_from_corners([-hw / 2.0, y0 - wall - rail_t - wall, ring_h + 10.0 - hook_depth], [hw / 2.0, y0 - wall - rail_t, ring_h + 10.0 - wall + 0.5]);
let body = fuse_all([ring, back, top, drop]);
body - cylinder([0, 0, floor_t], "Z", ri, ring_h + 20.0)
