// Toilet cubicle indicator bolt thumb turn: 50 mm round rose 4 mm thick with a 1 mm edge chamfer, a 40 x 12 mm turn lever 14 mm tall with 2 mm rounded top edges, and an 8 mm square spindle socket 10 mm deep in a 16 mm boss underneath
let rose_d = 50.0; // [40.0, 70.0] Rose diameter (mm)
let lever_len = 40.0; // [28.0, 55.0] Lever length (mm)
let lever_h = 14.0; // [8.0, 22.0] Lever height (mm)
let spindle = 8.0; // [6.0, 10.0] Square spindle size (mm)
const rose_t = 4.0;
const lever_w = 12.0;
let rr = rose_d / 2.0;
let rose = cylinder([0, 0, 0], "Z", rr, rose_t);
let rose = rose.chamfer(1.0, rose.edges(">Z"));
let ll = min(lever_len, rose_d - 4.0);
let lever = box_centered(ll, lever_w, lever_h).translate([0, 0, rose_t - 0.5 + lever_h / 2.0]);
let lever = lever.fillet(2.0, lever.edges(">Z"));
let boss = cylinder([0, 0, -10.0], "Z", spindle / 2.0 + 4.0, 10.5);
let body = fuse_all([rose, lever, boss]);
body - box_centered(spindle, spindle, 20.0).translate([0, 0, -10.0])
