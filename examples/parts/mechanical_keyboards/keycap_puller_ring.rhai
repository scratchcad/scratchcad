// Keycap puller: 30 mm finger ring with two 2 mm wire-style arms 45 mm long, 19 mm apart, ending in 2 mm inward hooks
let span = 19.0; // [17.0, 24.0] Arm spacing (mm)
let arm = 45.0; // [35.0, 60.0] Arm length (mm)
const t = 2.0;
let ring = cylinder([0, 0, 0], "Y", 15.0, 6.0) - cylinder([0, -1.0, 0], "Y", 11.0, 8.0);
let bridge = box_from_corners([-span / 2.0 - t, 0, -15.0 - t], [span / 2.0 + t, 6.0, -14.0]);
let arms = box_from_corners([-span / 2.0 - t, 0, -15.0 - arm], [-span / 2.0, 6.0, -14.5]) + box_from_corners([span / 2.0, 0, -15.0 - arm], [span / 2.0 + t, 6.0, -14.5]);
let hooks = box_from_corners([-span / 2.0 - 0.01, 0, -15.0 - arm], [-span / 2.0 + 2.0, 6.0, -15.0 - arm + 1.5]) + box_from_corners([span / 2.0 - 2.0, 0, -15.0 - arm], [span / 2.0 + 0.01, 6.0, -15.0 - arm + 1.5]);
ring + bridge + arms + hooks
