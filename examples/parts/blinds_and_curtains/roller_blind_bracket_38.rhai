// Roller blind bracket for 38 mm tubes: 45 x 50 mm L, 2.5 mm, 8 mm pin socket, 2 x 4 mm screw holes
let height = 50.0; // [35.0, 70.0] Bracket height (mm)
let depth = 45.0; // [30.0, 60.0] Projection (mm)
let width = 22.0; // [15.0, 30.0] Width (mm)
let t = 2.5; // [2.0, 4.0] Thickness (mm)
let back = box_from_corners([0, 0, 0], [width, t, height]);

let plate = box_from_corners([0, depth - t, 0], [width, depth, height]) - cylinder([width / 2.0, depth - t - 1.0, height * 0.6], "Y", 4.0, t + 2.0) - box_from_corners([width / 2.0 - 2.0, depth - t - 1.0, height * 0.6], [width / 2.0 + 2.0, depth + 1.0, height + 1.0]);
let side = box_from_corners([0, 0, 0], [t, depth, height * 0.4]);
back + plate + side - cylinder([width / 2.0, -1, height * 0.25], "Y", 2.0, t + 2.0) - cylinder([width / 2.0, -1, height * 0.8], "Y", 2.0, t + 2.0)
