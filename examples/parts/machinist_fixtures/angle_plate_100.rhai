// Machinist angle plate: 100 x 75 x 75 mm L of 12 mm walls with two 40 mm gussets, three 10 x 30 mm T-bolt slots in each face and 1 mm edge chamfers
let width = 100.0; // [75.0, 150.0] Plate width (mm)
let leg = 75.0; // [60.0, 120.0] Leg height (mm)
const t = 12.0;
let l = box_from_corners([0, 0, 0], [width, leg, t]) + box_from_corners([0, 0, 0], [width, t, leg]);
let gussets = [];
for x in [0.0, width - 8.0] { gussets.push(face(polygon([[x, t - 0.01, t - 0.01], [x, 40.0, t - 0.01], [x, t - 0.01, 40.0]])).extrude([8.0, 0, 0])); }
let slots = [];
for i in 0..3 {
    let x = width * (i.to_float() + 0.5) / 3.0;
    slots.push(box_from_corners([x - 5.0, t + 15.0, -1.0], [x + 5.0, t + 45.0, t + 1.0]));
    slots.push(box_from_corners([x - 5.0, -1.0, t + 15.0], [x + 5.0, t + 1.0, t + 45.0]));
}
l + fuse_all(gussets) - fuse_all(slots)
