// Spring tine harrow clamp for 40 x 40 mm square tine bar: 40 mm long U saddle with 6 mm cheeks and 8 mm crown that drops over the bar, a 10.5 mm cross bolt hole through both cheeks 8 mm below the bar to lock it, and a 22 mm boss along the crown with a 12.5 mm bore along the bar for the tine coil bolt
let bar = 40.0; // [30.0, 60.0] Square bar size (mm)
let clamp_len = 40.0; // [30.0, 60.0] Clamp length (mm)
let cheek_t = 6.0; // [4.0, 10.0] Cheek thickness (mm)
let tine_bolt_d = 12.5; // [8.5, 16.5] Tine bolt bore (mm)
const crown_t = 8.0;
const drop = 18.0;
const cross_bolt = 10.5;
let b = bar + 0.5;
let ow = b + 2.0 * cheek_t;
let oh = crown_t + b + drop;
let rboss = max(11.0, tine_bolt_d / 2.0 + 4.0);
let saddle = box_from_corners([0, -ow / 2.0, 0], [clamp_len, ow / 2.0, oh]);
let boss = cylinder([0, 0, oh + 2.0], "X", rboss, clamp_len);
let body = saddle + boss;
body - fuse_all([
    box_from_corners([-1.0, -b / 2.0, -1.0], [clamp_len + 1.0, b / 2.0, drop + b]),
    cylinder([clamp_len / 2.0, -ow / 2.0 - 1.0, drop - 8.0], "Y", cross_bolt / 2.0, ow + 2.0),
    cylinder([-1.0, 0, oh + 2.0], "X", tine_bolt_d / 2.0, clamp_len + 2.0),
])
