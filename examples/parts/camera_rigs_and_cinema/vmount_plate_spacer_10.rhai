// Spacer for a V-mount battery plate: 10 mm thick, 75 x 100 mm with 6 mm corner radii, a 52 x 64 mm lightening pocket through the middle, four 4.5 mm holes on the V-mount plate's 47 x 76 mm pattern counterbored 8 mm, and two 1/4-20 clearance holes (6.5 mm) on 20 mm for the rig
let thickness = 10.0; // [4.0, 25.0] Spacer thickness (mm)
let width = 75.0; // [70.0, 90.0] Spacer width (mm)
let height = 100.0; // [95.0, 120.0] Spacer height (mm)
const hx = 47.0;
const hy = 76.0;
let s = box_centered(width, height, thickness).translate([0, 0, thickness / 2.0]);
let s = s.fillet(6.0, s.edges("|Z"));
let pocket = box_centered(width - 23.0, 64.0, thickness + 2.0).translate([0, 0, thickness / 2.0]);
let pocket = pocket.fillet(4.0, pocket.edges("|Z"));
let cuts = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        cuts.push(cylinder([sx * hx / 2.0, sy * hy / 2.0, -1.0], "Z", 2.25, thickness + 2.0));
        cuts.push(cylinder([sx * hx / 2.0, sy * hy / 2.0, thickness - 3.0], "Z", 4.0, 4.0));
    }
}
for sx in [-1.0, 1.0] {
    cuts.push(cylinder([sx * 10.0, height / 2.0 - 7.0, -1.0], "Z", 3.25, thickness + 2.0));
}
s - pocket - fuse_all(cuts)
