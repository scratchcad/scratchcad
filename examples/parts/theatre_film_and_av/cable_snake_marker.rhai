// Multicore snake channel marker: clip-on ring for 8 mm cables, 12 mm long, 1.2 mm wall, 6 mm mouth, 14 mm wide flat label pad along its length with a 10 mm number area recessed 0.6 mm
let cable = 8.0; // [4.0, 14.0] Cable diameter (mm)
let length = 12.0; // [8.0, 20.0] Marker length (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let r = cable / 2.0;
let ring = cylinder(r + wall, length) - cylinder([0, 0, -1.0], "Z", r, length + 2.0);
let mouth = box_from_corners([-cable * 0.75 / 2.0, 0, -1.0], [cable * 0.75 / 2.0, r + wall + 1.0, length + 1.0]);
let pad = box_from_corners([-7.0, -r - wall - 1.5, 0], [7.0, -r - 0.5, length]);
let label = box_from_corners([-5.0, -r - wall - 1.6, 1.0], [5.0, -r - wall - 1.0, length - 1.0]);
ring - mouth + pad - label
