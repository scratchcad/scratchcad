// Cage nut insertion tool: 120 x 18 x 4 mm lever with a 9.6 mm square-hole hook tip (two 2 mm prongs) that pulls cage-nut wings through rack holes, and a 25 mm finger loop
let length = 120.0; // [90.0, 150.0] Tool length (mm)
let hole = 9.5; // [9.0, 10.0] Rack square hole size (mm)
const t = 4.0;
const w = 18.0;
let bar = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, t]);
let loop_ = cylinder([length, 0, 0], "Z", 17.0, t) - cylinder([length, 0, -1.0], "Z", 12.5, t + 2.0);
let tip = box_from_corners([-hole + 1.0, -hole / 2.0 + 0.5, 0], [0.01, hole / 2.0 - 0.5, 2.0]) - box_from_corners([-hole + 3.0, -hole / 2.0 + 2.5, -1.0], [-1.0, hole / 2.0 - 2.5, 3.0]);
let hook = box_from_corners([-hole + 1.0, -hole / 2.0 + 0.5, -4.0], [-hole + 3.0, hole / 2.0 - 0.5, 0.01]);
bar + loop_ + tip + hook
