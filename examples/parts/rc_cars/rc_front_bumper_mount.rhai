// RC car front bumper mount: 60 x 20 mm plate 4 mm with two 3 mm chassis holes 40 mm apart, a 70 mm bumper bar 10 x 8 mm standing 15 mm forward on two posts
let width = 70.0; // [50.0, 110.0] Bumper width (mm)
let reach = 15.0; // [8.0, 30.0] Bumper offset (mm)
const t = 4.0;
let plate = box_centered(60.0, 20.0, t).translate([0, 0, t / 2.0]);
let posts = box_from_corners([-22.0, 9.0, 0], [-16.0, 10.0 + reach, t]) + box_from_corners([16.0, 9.0, 0], [22.0, 10.0 + reach, t]);
let bar = box_from_corners([-width / 2.0, 10.0 + reach - 1.0, 0], [width / 2.0, 10.0 + reach + 10.0, 8.0]);
let bar = bar.fillet(3.0, bar.edges("|Z and >Y"));
plate + posts + bar - cylinder([-20.0, 0, -1.0], "Z", 1.6, t + 2.0) - cylinder([20.0, 0, -1.0], "Z", 1.6, t + 2.0)
