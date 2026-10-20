// Kart chain guard snap clip for a 30 mm frame tube: 15 mm wide C-ring with 4 mm walls and a 22 mm snap opening underneath, and a 4 mm tab 30 mm long on top with an M6 hole (6.4 mm) for the chain guard
let tube_d = 30.0; // [20.0, 35.0] Frame tube diameter (mm)
let width = 15.0; // [10.0, 25.0] Clip width (mm)
let tab_len = 30.0; // [20.0, 45.0] Tab length (mm)
const wall = 4.0;
const tab_t = 4.0;
let ri = tube_d / 2.0 + 0.1;
let ro = ri + wall;
let ring = cylinder([0, 0, 0], "X", ro, width) - cylinder([-1.0, 0, 0], "X", ri, width + 2.0);
let opening = box_from_corners([-1.0, -tube_d * 0.37, -ro - 1.0], [width + 1.0, tube_d * 0.37, -ri * 0.5]);
let tab = box_from_corners([0, -4.0, ro - tab_t], [width, tab_len, ro]);
let body = ring - opening + tab;
let hole = cylinder([width / 2.0, tab_len - 8.0, ro - tab_t - 1.0], "Z", 3.2, tab_t + 2.0);
body - hole
