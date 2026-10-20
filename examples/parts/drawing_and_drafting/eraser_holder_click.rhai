// Click eraser holder: 10 x 5 mm stick eraser, 100 mm long oval barrel 14 x 9 mm, clip
let length = 100.0; // [80.0, 140.0] Length (mm)
let eraser_w = 10.0; // [6.0, 14.0] Eraser width (mm)
let eraser_t = 5.0; // [3.0, 8.0] Eraser thickness (mm)
let barrel = cylinder(7.0, length);
let oval = barrel & box_centered(14.0, 9.0, length * 2.0);
let b = oval.fillet(3.0, oval.edges("|Z"));
let slot = box_centered(eraser_w + 0.4, eraser_t + 0.4, length).translate([0, 0, length / 2.0 + 3.0]);
let clip = box_from_corners([-2.0, 4.49, length - 40.0], [2.0, 6.0, length - 2.0]) + box_from_corners([-2.0, 4.49, length - 4.0], [2.0, 6.5, length]);
let c = box_from_corners([-2.0, 5.5, length - 40.0], [2.0, 7.0, length - 34.0]);
b - slot + clip + c
