// Crimp training pinch block: 100 x 50 x 70 mm block with a 12 mm crimp edge, a 40 mm tall sloper face at 20 degrees on the back and a 25 mm two-finger pocket 20 mm deep
let crimp = 12.0; // [8.0, 20.0] Crimp depth (mm)
let pocket = 25.0; // [20.0, 35.0] Pocket width (mm)
const w = 100.0;
const d = 50.0;
const h = 70.0;
let b = box_from_corners([0, 0, 0], [w, d, h]);
let crimp_cut = box_from_corners([-1.0, crimp, h - 10.0], [w + 1.0, d + 1.0, h + 1.0]);
let sloper = face(polygon([[-1.0, d + 1.0, h - 10.0], [-1.0, d + 1.0, 20.0], [-1.0, d - 14.56, h - 10.0]])).extrude([w + 2.0, 0, 0]);
let poc = box_from_corners([w / 2.0 - pocket / 2.0, -1.0, 25.0], [w / 2.0 + pocket / 2.0, 20.0, 40.0]);
let b = b - crimp_cut - sloper - poc;
b.fillet(3.0, b.edges("|X and >Z")) - cylinder([w / 2.0, d / 2.0 + 5.0, -1.0], "Z", 5.0, h + 2.0)
