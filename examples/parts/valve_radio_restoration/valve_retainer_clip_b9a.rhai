// Valve retainer clip for B9A (noval) valves: 22 mm ring 8 mm tall, 1 mm wall, with 3 spring fingers 15 mm tall and a 30 x 8 mm chassis foot with a 3.2 mm hole
let valve = 22.0; // [18.0, 32.0] Valve envelope diameter (mm)
let fingers = 15.0; // [10.0, 25.0] Finger height (mm)
const wall = 1.0;
let r = valve / 2.0 + 0.3;
let ring = cylinder([0, 0, 0], "Z", r + wall, 8.0) - cylinder([0, 0, -1.0], "Z", r, 10.0);
let f = [];
for i in 0..3 { f.push(box_from_corners([r - 0.01, -2.5, 7.99], [r + wall, 2.5, 8.0 + fingers]).rotate_z(i.to_float() * 120.0)); }
let foot = box_from_corners([-r - wall - 15.0, -4.0, 0], [-r + 1.0, 4.0, 1.5]) - cylinder([-r - wall - 9.0, 0, -1.0], "Z", 1.6, 4.0);
ring + fuse_all(f) + foot
