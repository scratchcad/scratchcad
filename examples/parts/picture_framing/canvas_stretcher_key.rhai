// Canvas stretcher key (wedge): 30 x 22 mm triangle-ish wedge 4 mm thick tapering at 10 degrees, with a 2 mm nail hole so it can be tethered to the stretcher
let length = 30.0; // [20.0, 45.0] Key length (mm)
let width = 22.0; // [15.0, 30.0] Key width (mm)
let t = 4.0; // [3.0, 6.0] Key thickness (mm)
let k = face(polygon([[0, 0, 0], [length, 0, 0], [length * 0.35, width, 0], [0, width, 0]])).extrude([0, 0, t]);
let taper = face(polygon([[0, -1.0, t + 0.01], [0, -1.0, t * 0.4], [length + 1.0, -1.0, t + 0.01]])).extrude([0, width + 2.0, 0]);
k - taper - cylinder([length * 0.2, width * 0.6, -1.0], "Z", 1.0, t + 2.0)
