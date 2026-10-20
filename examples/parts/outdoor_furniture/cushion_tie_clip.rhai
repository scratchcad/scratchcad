// Outdoor cushion tie clip: wraps a 20 mm frame rail, 30 mm wide strap loop 2 mm, 15 mm button 4 mm
let rail = 20.0; // [12.0, 30.0] Rail diameter (mm)
let width = 30.0; // [20.0, 40.0] Clip width (mm)
let t = 2.0; // [1.5, 3.0] Strap thickness (mm)
let r = rail / 2.0;
let loop_ = cylinder([0, -width / 2.0, 0], "Y", r + t, width) - cylinder([0, -width / 2.0 - 1.0, 0], "Y", r, width + 2.0) - box_from_corners([-r * 0.5, -width, -r - t - 1.0], [r * 0.5, width, -r * 0.4]);
let tail = box_from_corners([r - 0.01, -width / 2.0, -t], [r + 25.0, width / 2.0, 0]);
let button = cylinder([r + 18.0, 0, -0.01], "Z", 7.5, 4.0);
loop_ + tail + button
