// 1/2 in drive socket rail clip: 12.6 mm square post 13 mm tall with a 4 mm detent ball pocket, 24 mm top plate, T-foot (20 mm under 14 mm neck) to slide in a steel socket rail
let post = 12.6; // [6.2, 19.0] Square post size (mm)
let post_height = 13.0; // [8.0, 20.0] Post height (mm)
let plate_w = 24.0; // [16.0, 34.0] Top plate size (mm)
let foot_w = 20.0; // [12.0, 30.0] Foot width (mm)
let neck_w = 14.0; // [8.0, 22.0] Neck width (mm)
const plate_t = 2.0;
const neck_h = 1.6;
const foot_h = 2.5;
let nw = min(neck_w, foot_w - 3.0);
let pw = max(plate_w, post + 2.0);
let foot = box_centered(pw, foot_w, foot_h).translate([0, 0, foot_h / 2.0]);
let neck = box_centered(pw, nw, neck_h + 0.2).translate([0, 0, foot_h + neck_h / 2.0]);
let plate = box_centered(pw, pw, plate_t).translate([0, 0, foot_h + neck_h + plate_t / 2.0]).fillet(2.0, "|Z");
let z0 = foot_h + neck_h + plate_t;
let p = box_centered(post, post, post_height).translate([0, 0, z0 + post_height / 2.0 - 0.1]).chamfer(1.0, ">Z");
let clip = fuse_all([foot, neck, plate, p]);
clip - cylinder([post / 2.0 - 2.5, 0, z0 + post_height * 0.55], "X", 2.0, 3.0) - sphere([post / 2.0 - 0.5, 0, z0 + post_height * 0.55], 2.0)
