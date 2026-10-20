// Laptop webcam privacy slider frame: 22 x 10 mm base 0.8 mm thick with a 6 x 4 mm lens window and 0.6 mm side rails with 0.3 mm retaining lips for the shutter
let length = 22.0; // [16.0, 30.0] Cover length (mm)
let window = 6.0; // [3.0, 8.0] Lens window width (mm)
const t = 0.8;
let frame = box_from_corners([0, 0, 0], [length, 10.0, t]) - box_from_corners([3.0, 3.0, -1.0], [3.0 + window, 7.0, t + 1.0]);
let rails = box_from_corners([0, 0, t - 0.01], [length, 1.0, t + 0.6]) + box_from_corners([0, 9.0, t - 0.01], [length, 10.0, t + 0.6]);
let lips = box_from_corners([0, 0.99, t + 0.4], [length, 1.3, t + 0.6]) + box_from_corners([0, 8.7, t + 0.4], [length, 9.01, t + 0.6]);
frame + rails + lips
