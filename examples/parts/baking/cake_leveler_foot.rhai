// Cake leveler foot: 50 x 30 mm foot 6 mm, 25 mm upright with 9 notches for a 1 mm wire at 5 mm steps from 10 mm
let foot_l = 50.0; // [35.0, 70.0] Foot length (mm)
let height = 60.0; // [40.0, 80.0] Upright height (mm)
let foot = box_from_corners([-foot_l / 2.0, -15.0, 0], [foot_l / 2.0, 15.0, 6.0]);
let f = foot.fillet(5.0, foot.edges("|Z"));
let up = box_from_corners([-6.0, -6.0, 5.99], [6.0, 6.0, height]);
let notches = [];
for k in 0..9 { notches.push(box_from_corners([-7.0, 3.0, 10.0 + k.to_float() * 5.0 - 0.6], [7.0, 7.0, 10.0 + k.to_float() * 5.0 + 0.6])); }
f + up - compound(notches) - cylinder([0, -7.0, height - 4.0], "Y", 1.5, 14.0)
