// Gravel board clip for concrete posts: 150 mm tall clip that hooks round a 100 mm post flange 10 mm thick, 25 mm wide, 3 mm steel with a 22 mm board lip and 2 screw holes
let flange = 10.0; // [6.0, 16.0] Post flange thickness (mm)
let board = 22.0; // [15.0, 30.0] Gravel board thickness (mm)
const t = 3.0;
const w = 25.0;
let back = box_from_corners([0, 0, 0], [t, w, 150.0]);
let hook = box_from_corners([0, 0, 150.0 - t], [flange + 2.0 * t, w, 150.0]) + box_from_corners([flange + t, 0, 130.0], [flange + 2.0 * t, w, 150.0]);
let shelf = box_from_corners([-board - t, 0, 0], [0.01, w, t]) + box_from_corners([-board - t, 0, 0], [-board, w, 25.0]);
back + hook + shelf - cylinder([-1.0, w / 2.0, 50.0], "X", 2.5, t + 2.0) - cylinder([-1.0, w / 2.0, 100.0], "X", 2.5, t + 2.0)
