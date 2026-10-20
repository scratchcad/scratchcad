// Nebuliser cup holder for a drip pole: 36 mm ring with a 3 mm wall and a 22 mm front opening for the cup's tubing, 15 mm tall, on a 35 mm arm 10 mm wide to a split clamp for a 25 mm pole with 3 mm wall, a 3 mm slit and two 10 mm ears with a 5.5 mm bolt hole
let cup_d = 36.0; // [28.0, 50.0] Cup diameter (mm)
let pole_d = 25.0; // [16.0, 32.0] Pole diameter (mm)
let arm_len = 35.0; // [20.0, 60.0] Arm length (mm)
let height = 15.0; // [10.0, 25.0] Holder height (mm)
let opening = 22.0; // [14.0, 30.0] Front opening (mm)
const wall = 3.0;
const ear = 10.0;
const slit = 3.0;
let rc = cup_d / 2.0;
let rp = pole_d / 2.0;
let cx = rc + wall + arm_len + rp + wall;
let ring = cylinder(rc + wall, height) - cylinder([0, 0, -1.0], "Z", rc, height + 2.0);
let op = min(opening, cup_d - 6.0);
let ring = ring - box_from_corners([-rc - wall - 1.0, -op / 2.0, -1.0], [0, op / 2.0, height + 1.0]);
let arm = box_from_corners([rc + 0.5, -5.0, 0], [cx - rp - 0.5, 5.0, height]);
let clamp = cylinder([cx, 0, 0], "Z", rp + wall, height);
let ears = box_from_corners([cx + rp - 1.0, -slit / 2.0 - wall, 0], [cx + rp + wall + ear, slit / 2.0 + wall, height]);
let body = fuse_all([ring, arm, clamp, ears]);
body - fuse_all([
    cylinder([cx, 0, -1.0], "Z", rp, height + 2.0),
    box_from_corners([cx, -slit / 2.0, -1.0], [cx + rp + wall + ear + 1.0, slit / 2.0, height + 1.0]),
    cylinder([cx + rp + wall + ear / 2.0, -10.0, height / 2.0], "Y", 2.75, 20.0),
])
