// Name badge holder: 76 x 25 mm insert pocket 0.5 mm, 1 mm walls, magnet pocket 20 x 5 x 2 mm behind
let width = 76.0; // [60.0, 100.0] Badge width (mm)
let height = 25.0; // [20.0, 40.0] Badge height (mm)
let t = 3.5; // [2.5, 5.0] Thickness (mm)
let body = box_centered(width + 4.0, height + 4.0, t).translate([0, 0, t / 2.0]);
let b = body.fillet(3.0, body.edges("|Z"));
let pocket = box_from_corners([-width / 2.0, -height / 2.0, t - 1.6], [width / 2.0 + 3.0, height / 2.0, t - 1.0]);
let window = box_from_corners([-width / 2.0 + 2.0, -height / 2.0 + 2.0, t - 1.01], [width / 2.0 - 2.0, height / 2.0 - 2.0, t + 1.0]);
let magnets = box_centered(20.0, 5.0, 4.0).translate([-20.0, 0, 0]) + box_centered(20.0, 5.0, 4.0).translate([20.0, 0, 0]);
b - pocket - window - magnets
