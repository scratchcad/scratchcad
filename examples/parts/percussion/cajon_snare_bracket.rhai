// Cajon snare wire bracket: 2 L-brackets 40 x 25 x 15 mm 2 mm with a 6 mm adjuster bore and 2 x 3 mm holes
let length = 40.0; // [30.0, 60.0] Bracket length (mm)
let width = 15.0; // [10.0, 25.0] Bracket width (mm)
let leg = 25.0; // [15.0, 35.0] Leg height (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let a = box_from_corners([0, 0, 0], [length, width, t]) + box_from_corners([0, 0, 0], [t, width, leg]);
a - cylinder([-1, width / 2.0, leg - 8.0], "X", 3.0, t + 2.0) - cylinder([length * 0.4, width / 2.0, -1], "Z", 1.5, t + 2.0) - cylinder([length * 0.8, width / 2.0, -1], "Z", 1.5, t + 2.0)
