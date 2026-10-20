// Sign post clamp band for a 76 mm post: two-half band 30 mm wide, 4 mm thick (one half modelled), with M8 lugs 20 mm and an 80 mm sign bracket flange with two 10 mm slots
let post = 76.0; // [48.0, 89.0] Post diameter (mm)
let width = 30.0; // [20.0, 50.0] Band width (mm)
const t = 4.0;
let r = post / 2.0;
let band = (cylinder([0, 0, 0], "Z", r + t, width) - cylinder([0, 0, -1.0], "Z", r, width + 2.0)) - box_from_corners([-r - t - 1.0, -r - t - 1.0, -1.0], [0, r + t + 1.0, width + 1.0]);
let lugs = box_from_corners([-20.0, r - 0.5, 0], [2.0, r + t, width]) + box_from_corners([-20.0, -r - t, 0], [2.0, -r + 0.5, width]);
let flange = box_from_corners([r + t - 1.0, -40.0, 0], [r + t + 4.0, 40.0, width]);
let holes = cylinder([-10.0, r - 2.0, width / 2.0], "Y", 4.25, t + 4.0) + cylinder([-10.0, -r - t - 2.0, width / 2.0], "Y", 4.25, t + 4.0);
let slots = box_centered(t + 8.0, 20.0, 10.0).translate([r + t + 1.5, 28.0 - 10.0, width / 2.0]) + box_centered(t + 8.0, 20.0, 10.0).translate([r + t + 1.5, -28.0 + 10.0, width / 2.0]);
band + lugs + flange - holes - slots - cylinder([0, 0, -1.0], "Z", r, width + 2.0)
