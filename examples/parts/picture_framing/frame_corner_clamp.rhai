// Picture frame corner clamp block: 70 x 70 x 20 mm L-block with a 90 degree inside corner for moulding up to 45 mm wide, a 10 mm relief hole at the corner and a 6 mm strap slot on the outside
let leg = 70.0; // [50.0, 100.0] Leg length (mm)
let width = 25.0; // [18.0, 35.0] Leg width (mm)
const h = 20.0;
let l = box_from_corners([0, 0, 0], [leg, width, h]) + box_from_corners([0, 0, 0], [width, leg, h]);
let relief = cylinder([width, width, -1.0], "Z", 5.0, h + 2.0);
let strap = box_from_corners([-1.0, -1.0, h / 2.0 - 3.0], [leg + 1.0, 3.0, h / 2.0 + 3.0]) + box_from_corners([-1.0, -1.0, h / 2.0 - 3.0], [3.0, leg + 1.0, h / 2.0 + 3.0]);
l - relief - strap
