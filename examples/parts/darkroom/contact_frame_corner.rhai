// Contact print frame corner clamp: 40 x 40 mm L corner 8 mm tall that holds 3 mm glass over 1 mm paper on a 6 mm board, with 12 mm legs, 4 mm outer walls and a 2 mm top lip over the stack
let glass = 3.0; // [2.0, 6.0] Glass thickness (mm)
let leg = 40.0; // [30.0, 60.0] Leg length (mm)
const lip = 4.0;
let h = glass + 7.0 + 2.0;
let l = box_from_corners([-2.0, -2.0, 0], [leg, 10.0, h]) + box_from_corners([-2.0, -2.0, 0], [10.0, leg, h]);
let pocket = box_from_corners([lip - 2.0, lip - 2.0, -1.0], [leg + 1.0, leg + 1.0, h - 2.0]);
l - pocket
