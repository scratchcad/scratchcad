// Fondant smoother paddle: 140 x 80 mm flat face 4 mm with 2 mm rounded edges, 70 mm D-handle 20 mm tall
let length = 140.0; // [100.0, 180.0] Paddle length (mm)
let width = 80.0; // [60.0, 100.0] Paddle width (mm)
let t = 4.0; // [3.0, 6.0] Plate thickness (mm)
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(12.0, plate.edges("|Z"));
let pp = p.fillet(1.5, p.edges(">Z"));
let handle = (box_centered(70.0, 12.0, 24.0).translate([0, 0, t + 12.0 - 0.01]) - box_centered(54.0, 14.0, 16.0).translate([0, 0, t + 8.0 - 0.01]));
let h = handle.fillet(3.0, handle.edges("|Y and >Z"));
pp + h
