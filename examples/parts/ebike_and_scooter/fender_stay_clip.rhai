// Mudguard stay clip: 4 mm stay, 20 x 12 mm clip 3 mm, M5 mounting hole, snap channel with 3 mm opening
let stay = 4.0; // [3.0, 6.0] Stay diameter (mm)
let length = 20.0; // [15.0, 30.0] Clip length (mm)
let width = 12.0; // [8.0, 16.0] Clip width (mm)
let plate = box_from_corners([0, 0, 0], [length, width, 3.0]) - cylinder([5.0, width / 2.0, -1], "Z", 2.6, 5.0);
let ch = cylinder([length - stay / 2.0 - 2.0, -1, 3.0 + stay / 2.0], "Y", stay / 2.0 + 1.8, width + 2.0).translate([0, 1, 0]) - cylinder([length - stay / 2.0 - 2.0, -1, 3.0 + stay / 2.0], "Y", stay / 2.0, width + 4.0) - box_from_corners([length - stay / 2.0 - 2.0 - 1.5, -1, 3.0 + stay], [length - stay / 2.0 - 2.0 + 1.5, width + 2.0, 3.0 + stay + 5.0]);
plate + (ch & box_from_corners([0, 0, 2.99], [length + 5.0, width, 20.0]))
