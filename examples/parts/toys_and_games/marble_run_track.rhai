// Marble run straight track: 120 mm long U channel for 16 mm marbles, 2 mm walls, peg-and-socket ends, 5% slope
let len = 120.0; // [60.0, 250.0] Length (mm)
let marble = 16.0; // [12.0, 25.0] Marble diameter (mm)
let r = marble / 2.0 + 1.0;
let channel = box_from_corners([0, -r - 2.0, -r - 2.0], [len, r + 2.0, 2.0]) - cylinder([-1, 0, 0], "X", r, len + 2.0) - box_from_corners([-1, -r, 0], [len + 1.0, r, 5.0]);
channel = channel + box_from_corners([len - 0.1, -3.0, -r - 2.0], [len + 6.0, 3.0, -r]) - box_from_corners([-0.1, -3.2, -r - 2.1], [6.2, 3.2, -r + 0.2]);
channel.rotate_y(atan(0.05) * 180.0 / PI())
