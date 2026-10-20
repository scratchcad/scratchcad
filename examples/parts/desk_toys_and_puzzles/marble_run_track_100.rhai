// Marble run straight track: 100 mm U channel for 16 mm marbles, 22 mm wide, 12 mm tall, 2 mm walls, with a 3 degree fall and 10 mm male/female joint tabs
let length = 100.0; // [60.0, 200.0] Track length (mm)
let marble = 16.0; // [12.0, 25.0] Marble diameter (mm)
const wall = 2.0;
let w = marble + 2.0 + 2.0 * wall;
let h = marble * 0.6 + wall;
let c = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, h]) - box_from_corners([-1.0, -w / 2.0 + wall, wall], [length + 1.0, w / 2.0 - wall, h + 1.0]);
let tab = box_from_corners([length - 0.01, -w / 2.0 + wall + 1.0, 0], [length + 10.0, w / 2.0 - wall - 1.0, wall]);
let socket = box_from_corners([-1.0, -w / 2.0 + wall + 0.8, -0.01], [10.0, w / 2.0 - wall - 0.8, wall * 0.5]);
(c + tab - socket).rotate_y(3.0)
