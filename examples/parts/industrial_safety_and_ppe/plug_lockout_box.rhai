// Electrical plug lockout box: 70 x 60 x 110 mm hollow box, 3 mm wall, one-piece body with an 18 mm cord exit slot in the base, padlock tab with 8 mm hole on the lid edge
let width = 70.0; // [50.0, 100.0] Box width (mm)
let depth = 60.0; // [40.0, 90.0] Box depth (mm)
let height = 110.0; // [80.0, 160.0] Box height (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
let cord = 18.0; // [8.0, 25.0] Cord exit width (mm)
let box_body = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let b = box_body.fillet(6.0, box_body.edges("|Z"));
let cavity = box_centered(width - 2.0 * wall, depth - 2.0 * wall, height).translate([0, 0, height / 2.0 + wall]);
let cv = cavity.fillet(3.0, cavity.edges("|Z"));
let slot = box_from_corners([-cord / 2.0, -1.0, -1.0], [cord / 2.0, depth, wall + 1.0]) + cylinder([0, -1.0, -1.0], "Z", cord / 2.0, wall + 2.0);
let tab = box_from_corners([-8.0, depth / 2.0 - 0.01 - 1.0, height - 20.0], [8.0, depth / 2.0 + 18.0, height - 17.0]);
let t = tab.fillet(6.0, tab.edges("|Z and >Y"));
(b - cv - slot + t) - cylinder([0, depth / 2.0 + 10.0, height - 25.0], "Z", 4.0, 10.0)
