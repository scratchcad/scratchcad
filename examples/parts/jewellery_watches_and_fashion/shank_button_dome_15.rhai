// Domed shank button, 24 ligne (15 mm) diameter, 4 mm high dome, 0.4 mm rim, with a 3.5 mm loop shank on the back and a 1.6 mm thread hole
let diameter = 15.0; // [10.0, 30.0] Button diameter (mm)
let dome_height = 4.0; // [2.0, 8.0] Dome height (mm)
let shank_height = 3.5; // [2.5, 6.0] Shank height (mm)
let thread_hole = 1.6; // [1.0, 2.5] Thread hole diameter (mm)
let r = diameter / 2.0;
let h = min(dome_height, r);
let big_r = (r * r + h * h) / (2.0 * h);
let rim = cylinder(r, 0.4);
let dome = sphere([0, 0, h - big_r + 0.4], big_r) & cylinder([0, 0, 0.2], "Z", r + 1.0, h + 1.0);
let shank = box_centered(2.6, 4.0, shank_height + 0.3).translate([0, 0, -(shank_height - 0.3) / 2.0]).fillet(1.2, "|X and <Z");
shank = shank - cylinder([-2.0, 0, -shank_height + 1.4], "X", thread_hole / 2.0, 4.0);
fuse_all([rim, dome, shank])
