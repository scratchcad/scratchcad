// Reading guide ruler: 200 x 40 x 2 mm with a 180 x 8 mm line window and 50 mm cm scale ticks on the top edge
let length = 200.0; // [150.0, 250.0] Length (mm)
let width = 40.0; // [30.0, 60.0] Width (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let window = 8.0; // [5.0, 12.0] Window height (mm)
let r = box_from_corners([0, 0, 0], [length, width, t]);
let rr = r.fillet(4.0, r.edges("|Z"));
let ticks = [];
for i in 0..=18 { ticks.push(box_from_corners([10.0 + i.to_float() * 10.0 - 0.2, width - (if i % 5 == 0 { 6.0 } else { 3.5 }), t - 0.4], [10.0 + i.to_float() * 10.0 + 0.2, width + 1.0, t + 1.0])); }
rr - box_from_corners([10.0, 12.0, -1], [length - 10.0, 12.0 + window, t + 1.0]) - compound(ticks)
