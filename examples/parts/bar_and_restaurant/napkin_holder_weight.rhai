// Napkin holder arm weight: 160 x 20 mm bar 8 mm thick with a 12 mm center post 100 mm, 2 grip notches
let length = 160.0; // [120.0, 220.0] Bar length (mm)
let width = 20.0; // [15.0, 30.0] Bar width (mm)
let t = 8.0; // [5.0, 12.0] Bar thickness (mm)
let post_h = 100.0; // [60.0, 150.0] Post height (mm)
let bar = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let b = bar.fillet(width / 2.0 - 0.5, bar.edges("|Z"));
let post = cylinder([0, 0, t - 0.01], "Z", 6.0, post_h) + sphere([0, 0, t + post_h], 9.0);
b + post - cylinder([-length / 2.0 + 20.0, -width, t + 2.0], "Y", 4.0, width * 2.0) - cylinder([length / 2.0 - 20.0, -width, t + 2.0], "Y", 4.0, width * 2.0)
