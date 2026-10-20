// Clamp-on desk bag hook: fits 15 to 30 mm desk edge, 40 mm wide, 5 mm walls, 50 mm deep hook below
let desk = 30.0; // [15.0, 45.0] Max desk thickness (mm)
let width = 40.0; // [25.0, 60.0] Width (mm)
let t = 5.0; // [4.5, 8.0] Wall (mm)
let c = box_from_corners([0, 0, 0], [50.0, width, desk + 2.0 * t]) - box_from_corners([t, -1, t], [51.0, width + 1.0, desk + t]);
let drop = box_from_corners([0, 0, -60.0], [t, width, 0.01]);
let hook = box_from_corners([0, 0, -60.0], [50.0, width, -60.0 + t]) + box_from_corners([50.0 - t, 0, -60.0], [50.0, width, -40.0]);
let h = c + drop + hook;
h.fillet(2.0, h.edges("|Y"))
