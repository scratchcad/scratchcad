// Kicker outboard bracket backing pad in HDPE: 200 x 150 x 19 mm board with 10 mm rounded corners and 2 mm chamfered face edges, four 10.5 mm holes for 3/8 in through bolts on a 150 x 100 mm pattern counterbored 22 mm by 4 mm, and a 3 mm drain groove 6 mm wide across the back
let width = 200.0; // [160.0, 300.0] Pad width (mm)
let height = 150.0; // [120.0, 220.0] Pad height (mm)
let thickness = 19.0; // [12.0, 30.0] Pad thickness (mm)
const bolt_x = 150.0;
const bolt_y = 100.0;
let pad = box_centered(width, height, thickness).translate([0, 0, thickness / 2.0]);
let pad = pad.fillet(10.0, pad.edges("|Z"));
let pad = pad.chamfer(2.0, pad.edges(">Z"));
let cuts = [box_centered(width + 2.0, 6.0, 6.0)];
for s in [-1.0, 1.0] {
    for t in [-1.0, 1.0] {
        cuts.push(cylinder([s * bolt_x / 2.0, t * bolt_y / 2.0, -1.0], "Z", 5.25, thickness + 2.0));
        cuts.push(cylinder([s * bolt_x / 2.0, t * bolt_y / 2.0, thickness - 4.0], "Z", 11.0, 5.0));
    }
}
pad - fuse_all(cuts)
