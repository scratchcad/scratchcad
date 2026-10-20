// Drawing compass leg: 110 mm, 6 x 4 mm section, 2 mm needle socket with set screw boss, hinge knuckle
let length = 110.0; // [80.0, 150.0] Leg length (mm)
let width = 6.0; // [4.0, 8.0] Width (mm)
let depth = 4.0; // [3.0, 6.0] Depth (mm)
let leg = loft([rect(plane([0, 0, 0], [0, 0, 1]), width * 0.6, depth * 0.8), rect(plane([0, 0, length], [0, 0, 1]), width, depth)], true);
let knuckle = cylinder([0, -depth / 2.0, length + 4.0], "Y", 5.0, depth / 2.0) - cylinder([0, -depth, length + 4.0], "Y", 1.5, depth * 2.0);
let neck = box_from_corners([-width / 2.0, -depth / 2.0, length - 0.01], [width / 2.0, 0, length + 4.0]);
let boss = cylinder([0, 0, 2.0], "X", 2.0, width * 0.6);
leg + neck + knuckle + boss - cylinder([0, 0, -1], "Z", 1.0, 12.0) - cylinder([0, 0, 4.0], "X", 0.8, width)
