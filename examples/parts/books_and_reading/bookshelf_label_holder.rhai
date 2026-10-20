// Library shelf label holder: 75 x 25 mm card slot 1 mm, clips on a 19 mm shelf edge, 1.6 mm walls
let card_w = 75.0; // [50.0, 100.0] Card width (mm)
let card_h = 25.0; // [15.0, 40.0] Card height (mm)
let shelf = 19.0; // [15.0, 25.0] Shelf thickness (mm)
let t = 1.6; // [1.2, 2.5] Wall (mm)
let face = box_from_corners([0, -t * 2.0 - 1.0, 0], [card_w + 4.0, 0, card_h + 2.0 * t]) - box_from_corners([2.0, -t - 1.0, t], [card_w + 5.0, -t, card_h + t]) - box_from_corners([5.0, -t * 2.0 - 2.0, t + 3.0], [card_w - 1.0, -t - 0.9, card_h + t - 3.0]);
let clip = box_from_corners([0, -0.01, card_h + 2.0 * t - t], [card_w + 4.0, 15.0, card_h + 2.0 * t]) + box_from_corners([0, 15.0 - t, card_h + 2.0 * t - shelf - t], [card_w + 4.0, 15.0, card_h + 2.0 * t]);
face + clip
