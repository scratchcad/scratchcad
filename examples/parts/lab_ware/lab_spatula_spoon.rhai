// Double-ended lab spatula: 180 mm long 6 x 2 mm steel bar, 30 x 10 mm flat paddle, 18 mm spoon on the other end
let len = 180.0; // [120.0, 250.0] Length (mm)
let bar = box_centered(len - 30.0, 6.0, 2.0);
let paddle = box_centered(30.0, 10.0, 1.0).translate([len / 2.0 - 5.0, 0, -0.5]).fillet(4.0, "|Z and >X");
let c = [-len / 2.0 + 9.0, 0, 8.0];
let spoon = (sphere(c, 12.0) - sphere(c, 11.0)) & box_from_corners([-len / 2.0 - 10.0, -15.0, -5.0], [-len / 2.0 + 30.0, 15.0, 0.5]);
fuse_all([bar, paddle, spoon])
