// Kitchen plinth leg clip: snaps onto a 28 mm round plinth leg, 30 mm wide C-clip 3 mm thick, with a 25 x 12 mm tongue 4 mm thick that slides into a plinth board bracket
let leg = 28.0; // [24.0, 36.0] Leg diameter (mm)
let width = 30.0; // [20.0, 40.0] Clip width (mm)
const t = 3.0;
let r = leg / 2.0;
let c = cylinder([0, 0, 0], "Z", r + t, width) - cylinder([0, 0, -1.0], "Z", r, width + 2.0) - box_from_corners([-r * 0.75, -r - t - 1.0, -1.0], [r * 0.75, -r * 0.5, width + 1.0]);
let tongue = box_from_corners([-6.0, r + t - 0.5, width / 2.0 - 2.0], [6.0, r + t + 25.0, width / 2.0 + 2.0]);
c + tongue
