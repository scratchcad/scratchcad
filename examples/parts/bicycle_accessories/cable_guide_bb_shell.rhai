// Bottom bracket cable guide: 3 grooves for 5 mm housings on a 35 x 25 mm saddle 4 mm, center M5 bolt hole
let width = 35.0; // [25.0, 45.0] Guide width (mm)
let length = 25.0; // [18.0, 35.0] Guide length (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let g = box_centered(width, length, t + 2.5).translate([0, 0, (t + 2.5) / 2.0]);
let gg = g.fillet(3.0, g.edges("|Z"));
let grooves = [];
for x in [-10.0, 10.0] { grooves.push(cylinder([x, -length, t + 2.5], "Y", 2.6, length * 2.0)); }
gg - fuse_all(grooves) - cylinder([0, 0, -1], "Z", 2.6, t + 4.0) - cylinder([0, 0, t - 1.0], "Z", 4.5, 4.0)
