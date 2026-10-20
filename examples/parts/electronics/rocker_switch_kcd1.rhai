// KCD1 rocker switch: 21 x 15 mm bezel 2 mm thick, 19 x 13 mm body 13 mm deep, curved rocker, snap clips, two tabs
let bezel_w = 21.0; // [15.0, 30.0] Bezel width (mm)
let bezel_h = 15.0; // [10.0, 25.0] Bezel height (mm)
let body_w = 19.0; // [13.0, 28.0] Body width (mm)
let body_h = 13.0; // [8.0, 23.0] Body height (mm)
let bezel = box_centered(bezel_w, bezel_h, 2.0).translate([0, 0, 1.0]).fillet(1.0, "|Z") - box_centered(bezel_w - 3.0, bezel_h - 3.0, 4.0);
let body = box_centered(body_w, body_h, 13.0).translate([0, 0, -6.5 + 0.01]);
let rocker = (cylinder([-(bezel_w - 4.0) / 2.0, 0, -12.0], "X", 15.0, bezel_w - 4.0) & box_centered(bezel_w - 4.0, bezel_h - 4.0, 30.0)) & box_centered(bezel_w, bezel_h, 3.5).translate([0, 0, 1.75]);
let clips = box_centered(0.8, 6.0, 6.0).translate([body_w / 2.0 + 0.3, 0, -5.0]) + box_centered(0.8, 6.0, 6.0).translate([-body_w / 2.0 - 0.3, 0, -5.0]);
let tabs = box_centered(4.8, 0.8, 7.0).translate([0, -3.0, -16.5]) + box_centered(4.8, 0.8, 7.0).translate([0, 3.0, -16.5]);
fuse_all([bezel, body, rocker.rotate_x(8), clips, tabs])
