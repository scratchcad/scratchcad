// Clothes hanger size marker ring: 30 mm disc 2 mm, fits a 4 mm hanger hook, 9 mm slot opening, label recess
let diameter = 30.0; // [22.0, 45.0] Disc diameter (mm)
let t = 2.0; // [1.2, 3.0] Thickness (mm)
let hook = 4.0; // [3.0, 6.0] Hook wire diameter (mm)
let disc = cylinder(diameter / 2.0, t);
disc - cylinder([0, 0, -1], "Z", hook / 2.0 + 3.0, t + 2.0) - box_from_corners([-hook / 2.0, 0, -1], [hook / 2.0, diameter, t + 2.0]) - (cylinder([0, 0, t - 0.4], "Z", diameter / 2.0 - 1.5, 1.0) - cylinder([0, 0, t - 1.0], "Z", hook / 2.0 + 5.0, 2.0))
