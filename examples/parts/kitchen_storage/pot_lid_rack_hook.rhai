// Cabinet door pot lid hook: 60 mm deep J-hook 20 mm wide 3 mm, screw plate 20 x 40 mm with 2 holes, 15 mm lip
let depth = 60.0; // [40.0, 90.0] Hook depth (mm)
let width = 20.0; // [15.0, 30.0] Width (mm)
let t = 3.0; // [2.8, 5.0] Thickness (mm)
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, 40.0]);
let arm = box_from_corners([-width / 2.0, t - 0.01, 0], [width / 2.0, depth, t]);
let lip = box_from_corners([-width / 2.0, depth - t, 0], [width / 2.0, depth, 15.0]);
let h = plate + arm + lip;
h.fillet(1.2, h.edges("|X")) - cylinder([0, -1, 15.0], "Y", 2.0, t + 2.0) - cylinder([0, -1, 32.0], "Y", 2.0, t + 2.0)
