// Eyeglass hinge barrel spacer washer: 2.6 mm OD, 1.5 mm ID for a 1.4 mm hinge screw, 0.3 mm thick nylon shim, with a 0.2 mm locating lip
let od = 2.6; // [2.0, 3.5] Washer OD (mm)
let id = 1.5; // [1.1, 1.8] Washer ID (mm)
const t = 0.3;
let w = cylinder([0, 0, 0], "Z", od / 2.0, t) - cylinder([0, 0, -1.0], "Z", id / 2.0, t + 2.0);
let lip = cylinder([0, 0, t - 0.01], "Z", id / 2.0 + 0.25, 0.2) - cylinder([0, 0, -1.0], "Z", id / 2.0, 2.0);
w + lip
