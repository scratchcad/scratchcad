// Mouse bungee: 70 mm weighted base 15 mm thick, 80 mm spring post 8 mm, cable clip 4 mm at the top
let base_d = 70.0; // [50.0, 100.0] Base diameter (mm)
let base_h = 15.0; // [10.0, 25.0] Base height (mm)
let post_h = 80.0; // [50.0, 120.0] Post height (mm)
let cable = 4.0; // [3.0, 6.0] Cable diameter (mm)
let base = cylinder(base_d / 2.0, base_h);
let b = base.fillet(5.0, base.edges(">Z"));
let post = cylinder([0, 0, base_h - 0.01], "Z", 4.0, post_h);
let clip = cylinder([0, -5.0, base_h + post_h], "Y", cable / 2.0 + 2.5, 10.0) - cylinder([0, -6.0, base_h + post_h], "Y", cable / 2.0, 12.0) - box_centered(cable * 0.8, 12.0, 10.0).translate([0, 0, base_h + post_h + 5.0]);
b + post + clip - cylinder([0, 0, -1], "Z", base_d / 2.0 - 6.0, 6.0)
