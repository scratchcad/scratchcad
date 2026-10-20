// Storage bin label holder: clips on a 2.5 mm bin lip, 60 x 30 mm card pocket 0.8 mm, 1.2 mm walls
let card_w = 60.0; // [40.0, 90.0] Card width (mm)
let card_h = 30.0; // [20.0, 45.0] Card height (mm)
let lip = 2.5; // [1.5, 4.0] Bin lip thickness (mm)
let t = 1.2; // [1.0, 2.0] Wall (mm)
let back = box_from_corners([0, 0, 0], [card_w + 4.0, t, card_h + 4.0]);
let front = box_from_corners([0, -0.8 - t, 0], [card_w + 4.0, -0.8, card_h + 4.0]) - box_from_corners([4.0, -0.8 - t - 1.0, 4.0], [card_w, -0.7, card_h]);
let sides = box_from_corners([0, -0.8 - t, 0], [2.0, 0.01, card_h + 4.0]) + box_from_corners([card_w + 2.0, -0.8 - t, 0], [card_w + 4.0, 0.01, card_h + 4.0]) + box_from_corners([0, -0.8 - t, 0], [card_w + 4.0, 0.01, 2.0]);
let hook = box_from_corners([10.0, 0, card_h + 4.0 - t], [card_w - 6.0, lip + 2.0 * t, card_h + 4.0]) + box_from_corners([10.0, lip + t, card_h - 6.0], [card_w - 6.0, lip + 2.0 * t, card_h + 4.0]);
back + front + sides + hook
