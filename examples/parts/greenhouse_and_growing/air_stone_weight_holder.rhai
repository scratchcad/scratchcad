// Air stone holder: weighted cradle that keeps a 40 x 15 mm cylinder air stone on the bottom of a DWC reservoir, 50 mm footprint, 12 mm thick base with a 25 mm nut pocket for ballast, 4 mm airline tube clip
// # Stone
let stone_d = 15.0; // [10.0, 30.0] Air stone diameter (mm)
let stone_length = 40.0; // [20.0, 60.0] Air stone length (mm)
// # Base
let base_t = 12.0; // [8.0, 20.0] Base thickness (mm)
let ballast = 25.0; // [15.0, 35.0] Ballast pocket diameter (mm)
let airline = 4.0; // [3.0, 6.0] Airline tube diameter (mm)
let L = stone_length + 10.0;
let W = max(50.0, ballast + 10.0);
let base = box_centered(L, W, base_t).translate([0, 0, base_t / 2.0]).fillet(6.0, "|Z");
let rs = stone_d / 2.0;
let cradle = box_from_corners([-L / 2.0, -rs - 3.0, base_t - 0.01], [L / 2.0, rs + 3.0, base_t + rs + 2.0]);
let bed = cylinder([-L / 2.0 - 1.0, 0, base_t + rs], "X", rs + 0.3, L + 2.0);
let mouth = box_from_corners([-L / 2.0 - 1.0, -rs * 0.8, base_t + rs], [L / 2.0 + 1.0, rs * 0.8, base_t + rs * 3.0]);
let pocket = cylinder([0, 0, -0.01], "Z", ballast / 2.0, base_t - 3.0).translate([0, 0, 0]);
let clip_post = box_from_corners([L / 2.0 - 0.5, -4.0, 0], [L / 2.0 + 8.0, 4.0, base_t]);
let clip_hole = cylinder([L / 2.0 + 4.0, 0, base_t - airline / 2.0 - 1.5], "Y", airline / 2.0 + 0.2, 20.0).translate([0, -10.0, 0]);
let clip_mouth = box_from_corners([L / 2.0 + 4.0 - airline * 0.35, -5.0, base_t - airline / 2.0 - 1.5], [L / 2.0 + 4.0 + airline * 0.35, 5.0, base_t + 1.0]);
(base + cradle + clip_post) - bed - mouth - pocket - clip_hole - clip_mouth
