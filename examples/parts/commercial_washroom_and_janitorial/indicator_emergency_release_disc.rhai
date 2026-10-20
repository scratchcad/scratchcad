// Cubicle indicator bolt outside emergency release: 50 mm round rose 4 mm thick with a 1 mm chamfer, a 38 x 14 mm indicator window recess 1 mm deep for the vacant/engaged flag, a 16 mm release knob 5 mm tall with a 9 x 2 mm coin slot, and an 8 mm square spindle bore
let rose_d = 50.0; // [40.0, 70.0] Rose diameter (mm)
let window_w = 38.0; // [24.0, 50.0] Indicator window width (mm)
let knob_d = 16.0; // [12.0, 24.0] Release knob diameter (mm)
let spindle = 8.0; // [6.0, 10.0] Square spindle size (mm)
const t = 4.0;
const knob_h = 5.0;
let rr = rose_d / 2.0;
let rose = cylinder([0, 0, 0], "Z", rr, t);
let rose = rose.chamfer(1.0, rose.edges(">Z"));
let kr = max(knob_d / 2.0, spindle * 0.75 + 2.0);
let ky = -rr * 0.35;
let knob = cylinder([0, ky, t - 0.5], "Z", kr, knob_h + 0.5);
let body = rose + knob;
let ww = min(window_w, rose_d * 0.75);
let wy = rr * 0.45;
let cuts = [
    box_centered(ww, 14.0, 2.0).translate([0, wy, t]),
    box_centered(min(9.0, 2.0 * kr - 3.0), 2.0, 4.0).translate([0, ky, t + knob_h]),
    box_centered(spindle, spindle, 2.0 * t).translate([0, ky, 0])
];
body - fuse_all(cuts)
