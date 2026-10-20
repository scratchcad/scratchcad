// Dashcam rear-view mirror stem mount: clamp around a 22 x 14 mm mirror stem, 20 mm tall 4 mm walls, split front with M4 pinch ears, 17 mm ball stud on a 14 mm neck
let stem_w = 22.0; // [16.0, 30.0] Stem width (mm)
let stem_d = 14.0; // [10.0, 20.0] Stem depth (mm)
let height = 20.0; // [14.0, 30.0] Clamp height (mm)
let wall = 4.0; // [3.0, 6.0] Wall (mm)
let ball = 17.0; // [15.0, 20.0] Ball diameter (mm)
let neck = 14.0; // [8.0, 25.0] Neck length (mm)

const gap = 2.0;
const ear = 9.0;
let ow = stem_w + 2.0 * wall;
let od = stem_d + 2.0 * wall;
let body = box_centered(ow, od, height).translate([0, 0, height / 2.0]);
body = body.fillet(min(wall - 0.5, 3.0), body.edges("|Z"));
let ears = box_from_corners([-gap / 2.0 - ear, od / 2.0 - 1.0, 0], [gap / 2.0 + ear, od / 2.0 + 9.0, height]);
ears = ears.fillet(3.0, ears.edges("|Z and >Y"));
let neck_r = ball * 0.3;
let neck_c = cylinder([0, -od / 2.0 + 1.0, height / 2.0], "-Y", neck_r, neck + 1.0);
let ball_s = sphere([0, -od / 2.0 - neck - ball * 0.4, height / 2.0], ball / 2.0);
let mount = fuse_all([body, ears, neck_c, ball_s]);
mount = mount - box_centered(stem_w, stem_d, height + 2.0).translate([0, 0, height / 2.0]);
mount = mount - box_from_corners([-gap / 2.0, 0, -1.0], [gap / 2.0, od / 2.0 + 10.0, height + 1.0]);
mount - cylinder([-ow, od / 2.0 + 4.5, height / 2.0], "X", 2.2, 2.0 * ow)
