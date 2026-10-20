// Outboard lower engine mount rubber: 40 mm rubber body 30 mm long with two 4 mm deep flats for anti-rotation, a 50 mm flange 4 mm thick at one end, and a bonded 18 mm steel sleeve with a 12.5 mm bore running 1 mm proud of both ends, as one piece
let body_d = 40.0; // [30.0, 60.0] Rubber body diameter (mm)
let length = 30.0; // [20.0, 50.0] Mount length (mm)
let bolt_d = 12.5; // [8.5, 16.5] Bolt hole diameter (mm)
const flange_t = 4.0;
let r = body_d / 2.0;
let rs = bolt_d / 2.0 + 2.75;
let f = min(4.0, r - rs - 1.5);
let body = cylinder([0, 0, 0], "Z", r, length) - box_from_corners([r - f, -r - 1.0, -1.0], [r + 1.0, r + 1.0, length + 1.0]) - box_from_corners([-r - 1.0, -r - 1.0, -1.0], [-r + f, r + 1.0, length + 1.0]);
let flange = cylinder([0, 0, 0], "Z", r + 5.0, flange_t);
let sleeve = cylinder([0, 0, -1.0], "Z", rs, length + 2.0);
(body + flange + sleeve) - cylinder([0, 0, -2.0], "Z", bolt_d / 2.0, length + 4.0)
