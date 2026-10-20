// 22 x 22 mm cover glass dispenser: 30 x 30 x 25 mm box, 22.5 mm square well, 0.3 mm exit slot, thumb window
let size = 22.5; // [18.0, 25.0] Cover glass size (mm)
let height = 25.0; // [15.0, 40.0] Stack height (mm)
let wall = 3.0; // [2.0, 4.0] Wall (mm)
let b = box_centered(size + 2.0 * wall, size + 2.0 * wall, height).translate([0, 0, height / 2.0]);
let bb = b.fillet(2.0, b.edges("|Z"));
bb - box_centered(size, size, height).translate([0, 0, height / 2.0 + 1.5]) - box_from_corners([-size / 2.0, -size, 1.5], [size / 2.0, 0, 1.8]) - box_from_corners([-6.0, size / 2.0 - 1.0, 4.0], [6.0, size, height + 1.0])
