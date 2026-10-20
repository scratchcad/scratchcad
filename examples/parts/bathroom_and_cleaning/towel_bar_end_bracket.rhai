// Towel bar end bracket for a 19 mm (3/4 in) bar: 50 mm wall disc 6 mm, 20 mm post 60 mm off the wall, 26 mm socket with a 19.2 mm blind bore and M4 grub screw hole
let bar_d = 19.2; // [16.0, 25.5] Bar bore (mm)
let standoff = 60.0; // [40.0, 90.0] Bar distance from the wall (mm)
let base_d = 50.0; // [40.0, 65.0] Wall disc diameter (mm)
let post_d = 20.0; // [14.0, 26.0] Post diameter (mm)
let sr = bar_d / 2.0 + 3.5;
let base = cylinder([0, 0, 0], "Y", base_d / 2.0, 6.0);
let b = base.chamfer(1.5, base.edges(">Y"));
let post = cylinder([0, 5.0, 0], "Y", post_d / 2.0, standoff - 5.0);
let socket = cylinder([-sr, standoff, 0], "X", sr, 2.0 * sr + 6.0);
let bore = cylinder([-sr + 6.0, standoff, 0], "X", bar_d / 2.0, 2.0 * sr + 6.0);
let screws = [cylinder([0, 0, -1], "Y", 2.25, 8.0).translate([0, 0, 15.0]), cylinder([0, 0, -1], "Y", 2.25, 8.0).translate([0, 0, -15.0])];
b + post + socket - bore - cylinder([sr, standoff, -sr - 1.0], "Z", 1.7, sr + 1.0) - compound(screws)
