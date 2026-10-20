// Headrest bag hook: snaps on a 12 mm headrest post, 45 mm hook 15 mm wide 5 mm thick, 5 kg rating
let post = 12.0; // [10.0, 15.0] Post diameter (mm)
let width = 15.0; // [10.0, 20.0] Hook width (mm)
let t = 5.0; // [3.0, 7.0] Hook thickness (mm)
let r = post / 2.0;
let clip = cylinder(r + t, width) - cylinder([0, 0, -1], "Z", r, width + 2.0) - box_from_corners([-r * 0.7, r * 0.3, -1], [r * 0.7, r + t + 1.0, width + 1.0]);
let arm = box_from_corners([-t / 2.0, -r - 45.0, 0], [t / 2.0, -r - t + 1.0, width]);
let hook = box_from_corners([-t / 2.0, -r - 45.0, 0], [20.0, -r - 45.0 + t, width]) + box_from_corners([20.0 - t, -r - 45.0, 0], [20.0, -r - 35.0, width]);
clip + arm + hook
