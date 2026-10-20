// Calligraphy guideline ruler: 300 x 40 x 3 mm rule with a 1.5 mm raised edge strip so ink does not wick, slots for x-height guides every 5 mm for 60 mm, and a 6 mm hanging hole
let length = 300.0; // [150.0, 450.0] Rule length (mm)
let slots = 12; // [6, 20] Number of guide slots
const w = 40.0;
const t = 3.0;
let r = box_from_corners([0, 0, 0], [length, w, t]);
let lift = box_from_corners([0, 0, -1.5], [length, 5.0, 0.01]);
let cuts = [cylinder([length - 8.0, w - 8.0, -1.0], "Z", 3.0, t + 2.0)];
for i in 0..slots { cuts.push(box_from_corners([20.0, 10.0, -1.0], [20.0 + 1.0, w - 6.0, t + 1.0]).translate([i.to_float() * 5.0, 0, 0])); }
r + lift - fuse_all(cuts)
