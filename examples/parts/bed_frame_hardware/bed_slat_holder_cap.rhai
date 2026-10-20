// Sprung bed slat holder cap: pocket for a 53 x 8 mm slat, 2 mm walls, 28 mm long, with a 10 mm round peg 12 mm long that pushes into the side rail
let slat_w = 53.0; // [38.0, 70.0] Slat width (mm)
let slat_t = 8.0; // [6.0, 12.0] Slat thickness (mm)
const wall = 2.0;
const len = 28.0;
let cap = box_from_corners([0, -slat_w / 2.0 - wall, -slat_t / 2.0 - wall], [len, slat_w / 2.0 + wall, slat_t / 2.0 + wall]) - box_from_corners([wall, -slat_w / 2.0, -slat_t / 2.0], [len + 1.0, slat_w / 2.0, slat_t / 2.0]);
let peg = cylinder([-12.0, 0, 0], "X", 5.0, 12.01);
cap + peg
