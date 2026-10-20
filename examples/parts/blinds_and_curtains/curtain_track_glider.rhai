// Curtain track glider: 12 x 8 x 10 mm runner for a 10 mm C-track, 6 mm eye, 2 wings 1.5 mm
let width = 12.0; // [8.0, 18.0] Runner width (mm)
let height = 10.0; // [6.0, 15.0] Height (mm)
let body = box_centered(width, 6.0, height).translate([0, 0, height / 2.0]);
let wings = box_centered(width, 10.0, 1.5).translate([0, 0, height - 0.75]);
let stem = box_centered(3.0, 3.0, 4.0).translate([0, 0, -1.99]);
let eye = cylinder([0, -1.5, -6.0], "Y", 3.0, 3.0) - cylinder([0, -2.0, -6.0], "Y", 1.6, 4.0);
body + wings + stem + eye
