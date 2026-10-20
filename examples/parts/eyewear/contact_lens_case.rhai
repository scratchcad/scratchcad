// Contact lens case body: two 20 mm wells 10 mm deep on 26 mm centres joined by a 6 mm bridge, 1.5 mm walls, each well with a 22 mm threaded-style collar 5 mm tall (cap seat)
let well = 20.0; // [16.0, 24.0] Well inner diameter (mm)
let depth = 10.0; // [7.0, 14.0] Well depth (mm)
const wall = 1.5;
let pitch = well + 2.0 * wall + 3.0;
let cups = [];
let bores = [];
for x in [-pitch / 2.0, pitch / 2.0] {
    cups.push(cylinder([x, 0, 0], "Z", well / 2.0 + wall, depth + wall));
    cups.push(cylinder([x, 0, depth + wall - 0.01], "Z", well / 2.0 + wall - 0.5, 5.0));
    bores.push(cylinder([x, 0, wall], "Z", well / 2.0, depth + 10.0));
}
let bridge = box_centered(pitch, 6.0, depth * 0.6).translate([0, 0, depth * 0.3]);
fuse_all(cups) + bridge - fuse_all(bores)
