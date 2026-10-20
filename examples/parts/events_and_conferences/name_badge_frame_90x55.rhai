// Conference name badge frame: 96 x 61 mm frame 3 mm thick for a 90 x 55 mm card, 1 mm card slot open at the top, 85 x 50 mm window and a 15 x 4 mm lanyard slot
let card_w = 90.0; // [80.0, 110.0] Card width (mm)
let card_h = 55.0; // [50.0, 75.0] Card height (mm)
const t = 3.0;
let w = card_w + 6.0;
let h = card_h + 6.0;
let f = box_from_corners([0, 0, 0], [w, h, t]);
let f = f.fillet(4.0, f.edges("|Z"));
let slot = box_from_corners([3.0, 3.0, 1.0], [w - 3.0, h + 1.0, 2.0]);
let window = box_from_corners([5.5, 5.5, 1.99], [w - 5.5, h - 5.5, t + 1.0]);
let lanyard = box_centered(15.0, 4.0, t + 2.0).translate([w / 2.0, h + 4.0, t / 2.0]);
let tab = box_from_corners([w / 2.0 - 12.0, h - 1.0, 0], [w / 2.0 + 12.0, h + 8.0, t]);
f + tab - slot - window - lanyard
