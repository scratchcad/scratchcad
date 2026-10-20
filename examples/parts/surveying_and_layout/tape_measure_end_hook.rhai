// Tape measure end hook: 25 mm blade width, 1 mm steel style, 8 mm hook lip, 2 rivet holes 2 mm, 20 mm tang
let blade = 25.0; // [16.0, 32.0] Blade width (mm)
let t = 1.0; // [0.6, 1.5] Hook thickness (mm)
let lip = 8.0; // [5.0, 12.0] Hook lip height (mm)
let tang = box_from_corners([0, -blade / 2.0 + 4.0, 0], [20.0, blade / 2.0 - 4.0, t]);
let face = box_from_corners([-t, -blade / 2.0 - 0.5, -lip + t], [0.01, blade / 2.0 + 0.5, t]);
tang + face - cylinder([8.0, -4.0, -1], "Z", 1.0, t + 2.0) - cylinder([8.0, 4.0, -1], "Z", 1.0, t + 2.0)
