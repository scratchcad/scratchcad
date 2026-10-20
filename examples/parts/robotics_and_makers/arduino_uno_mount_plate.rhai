// Arduino Uno R3 mounting plate: 80 x 60 mm 3 mm plate, four 5 mm tall standoffs with 3.2 mm holes at the Uno's (14.0, 2.5), (15.3, 50.7), (66.1, 7.6) and (66.1, 35.5) mm hole positions, lightening pocket and zip-tie slots
let margin = 6.0; // [3.0, 15.0] Margin around the board (mm)
let standoff_h = 5.0; // [3.0, 12.0] Standoff height (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
const board_l = 68.6;
const board_w = 53.3;
let holes = [[14.0, 2.5], [15.3, 50.7], [66.1, 7.6], [66.1, 35.5]];
let p = box_from_corners([-margin, -margin, 0], [board_l + margin, board_w + margin, t]).fillet(4.0, "|Z");
let bosses = [];
for h in holes { bosses.push(cylinder([h[0], h[1], t - 0.01], "Z", 3.0, standoff_h)); }
p = fuse_all([p] + bosses);
for h in holes { p -= cylinder([h[0], h[1], -1], "Z", 1.6, t + standoff_h + 2.0); }
p -= box_from_corners([24.0, 12.0, -1], [58.0, 44.0, t + 1.0]).fillet(4.0, "|Z");
for y in [-margin / 2.0, board_w + margin / 2.0] { p -= box_centered(4.0, 2.0, 10.0).translate([board_l / 2.0 - 15.0, y, 0]) + box_centered(4.0, 2.0, 10.0).translate([board_l / 2.0 + 15.0, y, 0]); }
p
