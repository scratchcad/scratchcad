// Medication cart drawer divider: 300 x 60 mm plate 2.5 mm thick with 6 mm locating tabs on each end, three 3 mm slots for cross dividers and a 30 x 15 mm finger hole near the top
let length = 300.0; // [200.0, 450.0] Divider length (mm)
let height = 60.0; // [40.0, 100.0] Divider height (mm)
let slots = 3; // [1, 6] Number of cross slots
const t = 2.5;
let d = box_from_corners([0, 0, 0], [length, t, height]) + box_from_corners([-6.0, 0, height - 20.0], [length + 6.0, t, height - 5.0]);
let cuts = [];
for i in 0..slots {
    let x = length * (i.to_float() + 1.0) / (slots.to_float() + 1.0);
    cuts.push(box_from_corners([x - 1.6, -1.0, -1.0], [x + 1.6, t + 1.0, height / 2.0]));
}
let hole = box_from_corners([length / 2.0 - 15.0, -1.0, height - 20.0], [length / 2.0 + 15.0, t + 1.0, height - 5.0]);
let x_hole = if slots % 2 == 1 { length / (slots.to_float() + 1.0) / 2.0 } else { 0.0 };
d - compound(cuts) - hole.translate([x_hole, 0, 0])
