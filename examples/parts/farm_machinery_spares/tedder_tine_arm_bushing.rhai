// Hay tedder tine arm flanged bushing: 30 mm sleeve 25 mm long with a 20.2 mm bore for a 20 mm pivot shaft, a 40 mm flange 4 mm thick, a 1.5 mm deep internal grease groove 4 mm wide at mid length fed by a 4 mm cross hole, and 0.8 mm bore chamfers at both ends
let bore = 20.2; // [12.2, 30.2] Bore (mm)
let sleeve_d = 30.0; // [18.0, 42.0] Sleeve diameter (mm)
let length = 25.0; // [15.0, 40.0] Overall length (mm)
let flange_d = 40.0; // [26.0, 56.0] Flange diameter (mm)
const flange_t = 4.0;
const groove_w = 4.0;
const groove_d = 1.5;
const c = 0.8;
let rb = bore / 2.0;
let rs = max(sleeve_d / 2.0, rb + 3.0);
let rf = max(flange_d / 2.0, rs + 4.0);
let zg = (length + flange_t) / 2.0;
let profile = polygon([
    [rb + c, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [rs, 0, flange_t], [rs, 0, length], [rb + c, 0, length],
    [rb, 0, length - c], [rb, 0, zg + groove_w / 2.0], [rb + groove_d, 0, zg + groove_w / 2.0],
    [rb + groove_d, 0, zg - groove_w / 2.0], [rb, 0, zg - groove_w / 2.0], [rb, 0, c],
]);
let bush = profile.to_face().revolve("Z", 360.0);
bush - cylinder([0, 0, zg], "X", 2.0, rs + 2.0)
