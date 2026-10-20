// Bin bag retainer clip: clips over a 3 mm bin rim with a 12 mm hook, 30 mm wide, 2.5 mm thick, with a 20 mm toothed gripping face of 5 teeth
let rim = 3.0; // [1.5, 6.0] Bin rim thickness (mm)
let width = 30.0; // [20.0, 50.0] Clip width (mm)
const t = 2.5;
let c = box_from_corners([0, 0, 0], [t, width, 30.0]) + box_from_corners([0, 0, 30.0 - t], [2.0 * t + rim + 2.0, width, 30.0]) + box_from_corners([t + rim + 2.0, 0, 18.0], [2.0 * t + rim + 2.0, width, 30.0]);
let teeth = [];
for i in 0..5 { teeth.push(face(polygon([[t - 0.01, 0, 2.0 + i.to_float() * 4.0], [t + 1.5, 0, 4.0 + i.to_float() * 4.0], [t - 0.01, 0, 6.0 + i.to_float() * 4.0]])).extrude([0, width, 0])); }
c + fuse_all(teeth)
