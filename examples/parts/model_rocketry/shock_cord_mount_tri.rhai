// Tri-fold shock cord mount plate: 25 x 50 mm, 0.8 mm, 3 mm cord slot window and fold lines
let width = 25.0; // [15.0, 40.0] Width (mm)
let length = 50.0; // [35.0, 80.0] Length (mm)
let t = 0.8; // [0.5, 1.5] Thickness (mm)
let p = box(width, length, t);
let folds = box_from_corners([-1, length / 3.0 - 0.3, t - 0.3], [width + 1.0, length / 3.0 + 0.3, t + 1.0]) + box_from_corners([-1, 2.0 * length / 3.0 - 0.3, t - 0.3], [width + 1.0, 2.0 * length / 3.0 + 0.3, t + 1.0]);
p - folds - box_from_corners([width / 2.0 - 5.0, 5.0, -1], [width / 2.0 + 5.0, 8.0, t + 1.0])
