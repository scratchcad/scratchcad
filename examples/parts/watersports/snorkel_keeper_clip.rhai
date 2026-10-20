// Snorkel keeper: 20 mm snorkel tube clip and 3 x 22 mm mask-strap slot, 30 x 25 mm, 3 mm
let tube = 20.0; // [16.0, 25.0] Snorkel tube diameter (mm)
let strap = 22.0; // [15.0, 30.0] Strap width (mm)
let t = 3.0; // [2.0, 4.0] Thickness (mm)
let ring = cylinder(tube / 2.0 + t, 12.0) - cylinder([0, 0, -1], "Z", tube / 2.0, 14.0) - box_from_corners([-tube * 0.3, tube / 2.0 - 2.0, -1], [tube * 0.3, tube, 13.0]);
let tab = box_from_corners([-strap / 2.0 - 4.0, -tube / 2.0 - t - 9.0, 0], [strap / 2.0 + 4.0, -tube / 2.0 - t + 1.0, 12.0]) - box_from_corners([-strap / 2.0, -tube / 2.0 - t - 6.0, -1], [strap / 2.0, -tube / 2.0 - t - 3.0, 13.0]);
ring + tab
