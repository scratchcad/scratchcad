// Ukulele saddle: 60 x 3 x 9 mm blank, top radiused 3 mm, 4 strings compensated
let length = 60.0; // [50.0, 70.0] Length (mm)
let t = 3.0; // [2.3, 3.5] Thickness (mm)
let height = 9.0; // [6.0, 12.0] Height (mm)
let blank = box_from_corners([-length / 2.0, -t / 2.0, 0], [length / 2.0, t / 2.0, height]);
let b = blank.fillet(t / 2.0 - 0.01, blank.edges("|Y and >Z"));
b.fillet(t / 2.0 - 0.02, b.edges("|X and >Z"))
