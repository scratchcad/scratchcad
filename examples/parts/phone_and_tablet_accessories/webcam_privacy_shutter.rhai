// Webcam privacy shutter for a 22 x 10 mm slider frame: 10 x 7.8 mm plate 0.35 mm thick with a 0.6 mm thumb ridge, slides under the frame's 0.3 mm lips
let length = 10.0; // [8.0, 14.0] Shutter length (mm)
let width = 7.8; // [7.0, 8.2] Shutter width to fit between rails (mm)
const t = 0.35;
let plate = box_from_corners([0, 0, 0], [length, width, t]);
let ridge = box_from_corners([length - 2.0, 1.0, t - 0.01], [length - 1.0, width - 1.0, t + 0.6]);
plate + ridge
