// Reading book stand: 280 x 200 mm back 5 mm at 70 degrees, 30 mm page ledge lip, 2 page-holder arms, rear prop (one solid)
let width = 280.0; // [200.0, 400.0] Stand width (mm)
let height = 200.0; // [150.0, 300.0] Back height (mm)
let t = 5.0; // [3.0, 8.0] Panel thickness (mm)
let angle = 70.0; // [55.0, 85.0] Back angle (degrees)
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height]).rotate_x(-(90.0 - angle));
let ledge = box_from_corners([-width / 2.0, -30.0, 0], [width / 2.0, t, t]) + box_from_corners([-width / 2.0, -30.0, 0], [width / 2.0, -30.0 + t, 15.0]);
let prop = box_from_corners([-30.0, 0, 0], [30.0, 120.0, t]);
let arms = box_from_corners([-width / 2.0 + 20.0, -15.0, 40.0], [-width / 2.0 + 30.0, 0, 44.0]).rotate_x(-(90.0 - angle)) + box_from_corners([width / 2.0 - 30.0, -15.0, 40.0], [width / 2.0 - 20.0, 0, 44.0]).rotate_x(-(90.0 - angle));
let a = arms + box_from_corners([-width / 2.0 + 20.0, -1.0, 38.0], [-width / 2.0 + 30.0, 1.0, 46.0]).rotate_x(-(90.0 - angle)) + box_from_corners([width / 2.0 - 30.0, -1.0, 38.0], [width / 2.0 - 20.0, 1.0, 46.0]).rotate_x(-(90.0 - angle));
back + ledge + prop + a
