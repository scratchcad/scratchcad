// Ice skate blade guard: 280 mm guard 25 mm tall, 14 mm wide, with a 4 mm blade channel 15 mm deep and two 6 mm drain holes; one-piece hard guard
let length = 280.0; // [220.0, 340.0] Guard length (mm)
let blade = 4.0; // [3.0, 6.0] Blade channel width (mm)
const h = 25.0;
const w = 14.0;
let g = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, h]);
let g = g.fillet(6.0, g.edges("|Y"));
g - box_from_corners([8.0, -blade / 2.0, h - 15.0], [length - 8.0, blade / 2.0, h + 1.0]) - cylinder([length * 0.3, -w, h - 15.0 - 1.0], "Y", 3.0, 2.0 * w) - cylinder([length * 0.7, -w, h - 15.0 - 1.0], "Y", 3.0, 2.0 * w)
