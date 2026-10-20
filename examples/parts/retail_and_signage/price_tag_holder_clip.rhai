// Shelf price tag holder: 100 x 39 mm label channel, 1.2 mm wall, clips on a 25 mm shelf lip
let length = 100.0; // [60.0, 1250.0] Length (mm)
let label_h = 39.0; // [26.0, 60.0] Label height (mm)
let lip = 25.0; // [15.0, 40.0] Shelf lip height (mm)
let t = 1.2; // [0.8, 2.0] Wall (mm)
let back = box_from_corners([-t, 0, 0], [t, length, label_h + t]);
let bottom = box_from_corners([-t, 0, 0], [4.0 + t, length, t]) + box_from_corners([4.0, 0, 0], [4.0 + t, length, 3.0]);
let top = box_from_corners([-t, 0, label_h], [4.0 + t, length, label_h + t]) + box_from_corners([4.0, 0, label_h - 3.0], [4.0 + t, length, label_h + t]);
let hook = box_from_corners([-t - 6.0, 0, label_h + t - 0.01 - t], [-t, length, label_h + t]) + box_from_corners([-t - 6.0, 0, label_h - lip], [-t - 6.0 + t, length, label_h + t]);
back + bottom + top + hook
