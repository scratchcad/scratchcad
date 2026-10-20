// 6 inch stovepipe damper plate: 148 mm disc 2 mm thick for a 152 mm pipe, with a 6.5 mm spindle bore boss across its diameter and four 20 mm draft holes
let pipe = 152.0; // [100.0, 200.0] Pipe ID (mm)
let draft = 20.0; // [0.0, 30.0] Draft hole diameter (mm)
const t = 2.0;
let r = pipe / 2.0 - 2.0;
let disc = cylinder([0, 0, -t / 2.0], "Z", r, t);
let boss = cylinder([-r, 0, 0], "X", 5.0, 2.0 * r) & cylinder([0, 0, -6.0], "Z", r, 12.0);
let d = disc + boss - cylinder([-r - 1.0, 0, 0], "X", 3.25, 2.0 * r + 2.0);
let holes = [];
if draft > 0.0 {
    for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * r * 0.5, sy * r * 0.45, -5.0], "Z", draft / 2.0, 10.0)); } }
    d - fuse_all(holes)
} else { d }
