// Screw-on cable clip for 6 mm cable: 8 mm wide strap, 1.2 mm thick, 4 mm screw lug
let cable_d = 6.0; // [3.0, 20.0] Cable diameter (mm)
let width = 8.0; // [5.0, 15.0] Strap width (mm)
let thickness = 1.2; // [0.8, 3.0] Strap thickness (mm)
let r = cable_d / 2.0;
let loop_part = (cylinder([0, -width / 2.0, r], "Y", r + thickness, width) - cylinder([0, -width, r], "Y", r, width * 2.0)) - box_from_corners([-r - 5, -width, -5], [0, width, r]);
let lug = box_from_corners([0, -width / 2.0, 0], [r + thickness + 9.0, width / 2.0, thickness]) - cylinder([r + thickness + 4.5, 0, -1], "Z", 2.1, thickness + 2.0);
let foot = box_from_corners([-r - thickness, -width / 2.0, 0], [-r, width / 2.0, r]);
fuse_all([loop_part, lug, foot])
