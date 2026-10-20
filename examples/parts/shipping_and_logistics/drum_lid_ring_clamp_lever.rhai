// Drum lid ring clamp lever: 120 mm lever 20 x 6 mm, 2 pivot ears 8 mm with 6 mm holes, hooked tip 10 mm
let length = 120.0; // [80.0, 160.0] Lever length (mm)
let width = 20.0; // [15.0, 30.0] Lever width (mm)
let t = 6.0; // [4.0, 8.0] Lever thickness (mm)
let lever = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let l = lever.fillet(width / 2.0 - 0.5, lever.edges("|Z and >X"));
let ears = box_from_corners([0, -width / 2.0, -10.0], [16.0, -width / 2.0 + 4.0, 0.01]) + box_from_corners([0, width / 2.0 - 4.0, -10.0], [16.0, width / 2.0, 0.01]);
let tip = box_from_corners([-10.0, -width / 2.0, 0], [0.01, width / 2.0, t]) + box_from_corners([-10.0, -width / 2.0, -6.0], [-7.0, width / 2.0, t]);
l + ears + tip - cylinder([8.0, -width, -5.0], "Y", 3.0, width * 2.0)
