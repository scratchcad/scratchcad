// Lever door handle on a rose: 52 mm rose 8 mm thick, 16 mm neck 25 mm long, 120 x 18 x 12 mm rounded lever, 8 mm square spindle hole
let lever_len = 120.0; // [90.0, 160.0] Lever length (mm)
let rose = cylinder([0, 0, 0], "Y", 26.0, 8.0).chamfer(1.5, ">Y");
let neck = cylinder([0, 6.0, 0], "Y", 8.0, 25.0);
let lever = box_from_corners([-8.0, 25.0, -9.0], [lever_len, 37.0, 9.0]).fillet(4.0);
fuse_all([rose, neck, lever]) - box_centered(8.0, 60.0, 8.0)
