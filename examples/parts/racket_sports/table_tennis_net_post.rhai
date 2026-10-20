// Table tennis net post with screw clamp: 12 mm post 152.5 mm tall (net height 15.25 cm) on a C-clamp for tables up to 30 mm thick, 25 mm wide jaws and an M8 clamp screw boss
let table = 30.0; // [15.0, 50.0] Max table top thickness (mm)
let post_h = 152.5; // [140.0, 160.0] Post height above table (mm)
const t = 6.0;
const w = 25.0;
let top = box_from_corners([0, 0, 0], [60.0, w, t]);
let spine = box_from_corners([60.0 - 0.01, 0, -table - t], [60.0 + t, w, t]);
let jaw = box_from_corners([30.0, 0, -table - t], [60.0 + 0.01, w, -table]);
let boss = cylinder([42.0, w / 2.0, -table - t - 10.0], "Z", 8.0, 10.01);
let post = cylinder([60.0 + t + 6.0, w / 2.0, -table - t], "Z", 6.0, table + t + post_h);
let link = box_from_corners([60.0 + t - 0.01, w / 2.0 - 6.0, -table - t], [60.0 + t + 6.0, w / 2.0 + 6.0, t]);
let cords = cylinder([60.0 + t + 6.0, w / 2.0 - 10.0, post_h - 6.0], "Y", 1.5, 20.0);
top + spine + jaw + boss + post + link - cylinder([42.0, w / 2.0, -table - t - 11.0], "Z", 3.4, t + 12.0) - cords
