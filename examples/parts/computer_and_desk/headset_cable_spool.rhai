// Earbud cable winder: 50 x 30 x 3 mm H-shaped winder with a 5 mm plug slot
let length = 50.0; // [35.0, 70.0] Length (mm)
let width = 30.0; // [20.0, 45.0] Width (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let blank = box_centered(length, width, t);
let b = blank.fillet(4.0, blank.edges("|Z"));
let notches = box_centered(length - 16.0, 12.0, t + 2.0).translate([0, width / 2.0, 0]) + box_centered(length - 16.0, 12.0, t + 2.0).translate([0, -width / 2.0, 0]);
let n = notches.fillet(3.0, notches.edges("|Z"));
b - n - box_centered(1.5, 6.0, t + 2.0).translate([length / 2.0 - 4.0, 0, 0]) - cylinder([length / 2.0 - 4.0, 3.0, -2], "Z", 2.5, 4.0)
