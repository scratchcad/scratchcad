// Model baseboard corner joiner: L bracket for 5 mm foamboard baseboard edges, 30 mm legs, 15 mm tall, 2 mm walls with a 5.2 mm slot channel on each leg
let board = 5.2; // [3.2, 10.2] Board thickness slot (mm)
let leg = 30.0; // [20.0, 50.0] Leg length (mm)
const wall = 2.0;
let o = board + 2.0 * wall;
let l = box_from_corners([0, 0, 0], [leg, o, 15.0]) + box_from_corners([0, 0, 0], [o, leg, 15.0]);
l - box_from_corners([wall, wall, wall], [leg + 1.0, wall + board, 16.0]) - box_from_corners([wall, wall, wall], [wall + board, leg + 1.0, 16.0])
