// Oscilloscope probe holder: bench clamp for 25 mm thick edge, 8 mm probe slot snap, 80 mm gooseneck stub socket 10 mm
let edge = 25.0; // [10.0, 40.0] Bench thickness (mm)
let probe = 8.0; // [6.0, 12.0] Probe barrel (mm)
let t = 5.0; // [3.0, 8.0] Wall (mm)
let c = box_from_corners([0, 0, 0], [40.0, 20.0, edge + 2.0 * t]) - box_from_corners([t, -1, t], [41.0, 21.0, edge + t]);
let boss = cylinder([20.0, 10.0, edge + 2.0 * t - 0.01], "Z", 8.0, 15.0) - cylinder([20.0, 10.0, edge + 2.0 * t + 3.0], "Z", 5.0, 15.0);
let snap = cylinder([-probe / 2.0 - 1.0, 0, 0], "Y", probe / 2.0 + 2.0, 20.0).translate([0, 0, edge + t]) - cylinder([-probe / 2.0 - 1.0, -1, edge + t], "Y", probe / 2.0, 22.0) - box_from_corners([-probe - 6.0, -1, edge + t + probe * 0.25], [-probe / 2.0 - 1.0 - probe * 0.35, 21.0, edge + t + probe]);
c + boss + snap - cylinder([30.0, 10.0, -1], "Z", 3.3, t + 2.0)
