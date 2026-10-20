// Surf wax comb: 70 x 50 x 3 mm card with 12 teeth 6 mm deep on one long edge, a straight scraper edge, and a 5 x 15 mm fin-key slot
let length = 70.0; // [55.0, 90.0] Comb length (mm)
let teeth = 12; // [8, 18] Number of teeth
const width = 50.0;
const t = 3.0;
let card = box_from_corners([0, 0, 0], [length, width, t]);
let card = card.fillet(5.0, card.edges("|Z"));
let p = (length - 10.0) / teeth.to_float();
let gaps = [];
for i in 0..teeth - 1 { gaps.push(box_from_corners([5.0 + p * (i.to_float() + 1.0) - 1.0, -1.0, -1.0], [5.0 + p * (i.to_float() + 1.0) + 1.0, 6.0, t + 1.0])); }
let key = box_from_corners([length / 2.0 - 7.5, width - 15.0, -1.0], [length / 2.0 + 7.5, width - 10.0, t + 1.0]);
card - fuse_all(gaps) - key
