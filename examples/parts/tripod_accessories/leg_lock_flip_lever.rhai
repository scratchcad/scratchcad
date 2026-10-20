// Tripod flip-lock lever: 40 mm lever 12 mm wide 4 mm thick, 25 mm clamp cam ring for a 25 mm leg, 3 mm pivot
let leg = 25.0; // [16.0, 32.0] Leg tube OD (mm)
let length = 40.0; // [30.0, 55.0] Lever length (mm)
let width = 12.0; // [8.0, 16.0] Lever width (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let ring = cylinder([0, 0, 0], "Z", leg / 2.0 + t, width) - cylinder([0, 0, -1], "Z", leg / 2.0 + 0.3, width + 2.0) - box_from_corners([-1.0, 0, -1], [1.0, leg, width + 1.0]);
let lever = box_from_corners([0, leg / 2.0, 0], [length, leg / 2.0 + t, width]);
let cam = cylinder([length - 5.0, leg / 2.0 + t / 2.0, 0], "Z", 4.0, width) - cylinder([length - 5.0, leg / 2.0 + t / 2.0, -1], "Z", 1.5, width + 2.0);
ring + lever + cam
