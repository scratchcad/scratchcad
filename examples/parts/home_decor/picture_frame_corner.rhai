// Picture frame corner protector / joiner: 40 mm legs, 20 mm moulding, 10 mm deep, 2 mm walls
let leg = 40.0; // [25.0, 60.0] Leg length (mm)
let moulding = 20.0; // [10.0, 40.0] Moulding width (mm)
let depth = 10.0; // [5.0, 20.0] Moulding depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = box_from_corners([-wall, -wall, -wall], [leg, moulding + wall, depth]) + box_from_corners([-wall, -wall, -wall], [moulding + wall, leg, depth]);
let inner = box_from_corners([0, 0, 0], [leg + 1.0, moulding, depth + 1.0]) + box_from_corners([0, 0, 0], [moulding, leg + 1.0, depth + 1.0]);
outer - inner
