// Auto-siphon racking clip: snaps on a 16 mm cane, clips over a 6 mm bucket rim, 30 mm wide, 3 mm walls
let cane = 16.0; // [10.0, 22.0] Cane diameter (mm)
let rim = 6.0; // [3.0, 10.0] Rim thickness (mm)
let width = 30.0; // [20.0, 40.0] Clip width (mm)
let t = 3.0; // [2.0, 4.0] Wall (mm)
let r = cane / 2.0;
let ring = cylinder(r + t, width) - cylinder([0, 0, -1], "Z", r, width + 2.0) - box_from_corners([-r * 0.7, -r - t - 1.0, -1], [r * 0.7, -r * 0.4, width + 1.0]);
let u = box_from_corners([-rim / 2.0 - t, r + t - 0.5, 0], [rim / 2.0 + t, r + t + 25.0, width]) - box_from_corners([-rim / 2.0, r + t + 5.0, -1], [rim / 2.0, r + t + 26.0, width + 1.0]);
ring + u
