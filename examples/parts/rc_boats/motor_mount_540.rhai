// RC boat motor mount for a 540-size motor: 36 mm can saddle, 3 mm front plate with 25 mm M3 hole spacing and a 12 mm boss hole, on a 50 x 40 mm base with four 3 mm screw holes
let can = 36.0; // [28.0, 42.0] Motor can diameter (mm)
let spacing = 25.0; // [16.0, 30.0] Face screw spacing (mm)
const t = 3.0;
let base = box_from_corners([-25.0, -20.0, 0], [25.0, 20.0, t]);
let plate = box_from_corners([-25.0, -20.0, 0], [-25.0 + t, 20.0, can / 2.0 + t + 20.0]);
let saddle = box_from_corners([0, -can / 2.0 - t, 0], [20.0, can / 2.0 + t, can / 2.0 + t]) - cylinder([-1.0, 0, can / 2.0 + t], "X", can / 2.0, 30.0);
let cz = can / 2.0 + t;
let cuts = [cylinder([-30.0, 0, cz], "X", 6.0, 10.0), cylinder([-30.0, -spacing / 2.0, cz], "X", 1.6, 10.0), cylinder([-30.0, spacing / 2.0, cz], "X", 1.6, 10.0)];
for x in [-12.0, 18.0] { for y in [-15.0, 15.0] { cuts.push(cylinder([x, y, -1.0], "Z", 1.6, t + 2.0)); } }
base + plate + saddle - fuse_all(cuts)
