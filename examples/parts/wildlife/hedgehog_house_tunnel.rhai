// Hedgehog house entrance tunnel: 130 x 130 mm square tunnel 300 mm long, 3 mm wall, open ends, 2 floor drain holes
let size = 130.0; // [110.0, 150.0] Tunnel opening (mm)
let length = 300.0; // [200.0, 400.0] Tunnel length (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let t = box_from_corners([0, 0, 0], [length, size + 2.0 * wall, size + 2.0 * wall]) - box_from_corners([-1, wall, wall], [length + 1.0, size + wall, size + wall]);
t - cylinder([length / 3.0, size / 2.0 + wall, -1], "Z", 5.0, wall + 2.0) - cylinder([2.0 * length / 3.0, size / 2.0 + wall, -1], "Z", 5.0, wall + 2.0)
