// Medicine bottle label magnifier clip: C ring 10 mm tall with a 2.5 mm wall that snaps onto a 40 mm bottle through a 28 mm opening, two 3 mm side arms holding a 36 mm lens ring 5 mm thick 30 mm out from the bottle, with a 30.4 mm lens seat (up to 4 mm under the bottle diameter) 1.5 mm deep behind a 27 mm sight hole
let bottle_d = 40.0; // [28.0, 60.0] Bottle diameter (mm)
let lens_d = 30.0; // [20.0, 40.0] Lens diameter (mm)
let stand_off = 30.0; // [15.0, 60.0] Lens distance from bottle (mm)
let ring_h = 10.0; // [6.0, 16.0] Clip ring height (mm)
const wall = 2.5;
const lens_t = 5.0;
const arm_t = 3.0;
let rb = bottle_d / 2.0;
let ro = rb + wall;
let rl = min(lens_d / 2.0 + 0.2, rb - 2.0);
let rlo = rl + 3.0;
let lx = rb + stand_off;
let ring = cylinder(ro, ring_h) - cylinder([0, 0, -1.0], "Z", rb, ring_h + 2.0);
let op = bottle_d * 0.7;
let ring = ring - box_from_corners([-ro - 1.0, -op / 2.0, -1.0], [-rb * 0.5, op / 2.0, ring_h + 1.0]);
let zc = ring_h / 2.0;
let lens = cylinder([lx, 0, zc], "X", rlo, lens_t) - cylinder([lx - 1.0, 0, zc], "X", rl - 1.7, lens_t + 2.0) - cylinder([lx + lens_t - 1.5, 0, zc], "X", rl, 2.0);
let ay = rl + 1.5;
let ax0 = sqrt(ro * ro - ay * ay) - 1.0;
fuse_all([
    ring,
    lens,
    box_from_corners([ax0, ay - arm_t / 2.0, 0], [lx + 1.0, ay + arm_t / 2.0, ring_h]),
    box_from_corners([ax0, -ay - arm_t / 2.0, 0], [lx + 1.0, -ay + arm_t / 2.0, ring_h]),
])
