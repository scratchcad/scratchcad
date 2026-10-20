// Microphone clip for a 22 mm handheld mic body: C-ring 20 mm long with 3 mm walls and a 17 mm mouth, on a swivel yoke with a 5/8-27 UNS insert boss (15.9 mm, 12 mm deep)
let mic = 22.0; // [18.0, 30.0] Mic body diameter (mm)
let length = 20.0; // [14.0, 30.0] Clip length (mm)
const wall = 3.0;
let r = mic / 2.0;
let ring = cylinder([0, 0, r + wall], "Y", r + wall, length) - cylinder([0, -1.0, r + wall], "Y", r, length + 2.0) - box_from_corners([-r * 0.77, -1.0, r + wall + r * 0.6], [r * 0.77, length + 1.0, 3.0 * r]);
let yoke = box_from_corners([-8.0, 0, -12.0], [8.0, length, 1.0]);
let boss = cylinder([0, length / 2.0, -28.0], "Z", 11.0, 16.01);
ring + yoke + boss - cylinder([0, length / 2.0, -29.0], "Z", 7.95, 13.0)
