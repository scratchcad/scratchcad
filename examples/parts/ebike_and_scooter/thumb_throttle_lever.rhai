// Scooter thumb throttle lever: 22.2 mm bar ring 12 mm wide, 35 mm paddle 20 mm wide, 3 mm magnet pocket
let bar = 22.2; // [22.0, 25.4] Bar diameter (mm)
let width = 12.0; // [8.0, 16.0] Ring width (mm)
let paddle = 35.0; // [25.0, 45.0] Paddle reach (mm)
let r = bar / 2.0;
let ring = cylinder([0, 0, 0], "Y", r + 3.0, width) - cylinder([0, -1, 0], "Y", r + 0.3, width + 2.0);
let arm = box_from_corners([r + 1.0, 0, -3.0], [r + paddle, width, 3.0]);
let pad = box_from_corners([r + paddle - 18.0, -4.0, -2.0], [r + paddle, width + 4.0, 4.0]);
let p = pad.fillet(3.0, pad.edges("|Z"));
ring + arm + p - cylinder([r + 6.0, width / 2.0, -4.0], "Z", 2.0, 2.5)
