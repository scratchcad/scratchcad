// Blind valance clip: 30 mm spring clip onto a 25 mm headrail, 12 mm wide, 1.5 mm, valance hook lip 6 mm
let rail = 25.0; // [18.0, 40.0] Headrail height (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let t = 1.5; // [1.0, 2.5] Thickness (mm)
let back = box_from_corners([0, 0, 0], [t, width, rail + t]);
let top = box_from_corners([0, 0, rail], [8.0, width, rail + t]);
let bottom = box_from_corners([0, 0, 0], [8.0, width, t]);
let tip = box_from_corners([8.0 - t, 0, 0], [8.0, width, 3.0]) + box_from_corners([8.0 - t, 0, rail - 2.0], [8.0, width, rail + t]);
let lip = box_from_corners([-6.0, 0, rail - 6.0], [0.01, width, rail - 6.0 + t]) + box_from_corners([-6.0, 0, rail - 6.0], [-6.0 + t, width, rail]);
back + top + bottom + tip + lip
