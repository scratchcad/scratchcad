// Cam roller follower arm: 60 mm between centers, 6 mm pivot, fork for a 10 x 4 mm roller on a 3 mm pin
let centers = 60.0; // [30.0, 100.0] Pivot to roller (mm)
let width = 12.0; // [8.0, 20.0] Arm width (mm)
let thickness = 10.0; // [6.0, 16.0] Thickness (mm)
let roller_w = 4.0; // [2.0, 8.0] Roller width (mm)
let arm = box_from_corners([0, -width / 2.0, 0], [centers, width / 2.0, thickness]) + cylinder(width / 2.0, thickness) + cylinder([centers, 0, 0], "Z", width / 2.0 + 2.0, thickness);
let fork = box_from_corners([centers - 8.0, -width, thickness / 2.0 - roller_w / 2.0 - 0.3], [centers + 10.0, width, thickness / 2.0 + roller_w / 2.0 + 0.3]);
arm - fork - cylinder([0, 0, -1], "Z", 3.0, thickness + 2.0) - cylinder([centers, 0, -1], "Z", 1.5, thickness + 2.0)
