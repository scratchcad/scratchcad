// Pipette tip rack re-fill spacer: 122 x 80 mm plate 2 mm thick with 96 tip holes 5.6 mm on a 9 mm pitch and 4 corner legs 10 mm tall to stack in a tip box
let hole = 5.6; // [4.5, 7.5] Tip hole diameter (mm)
let leg = 10.0; // [5.0, 20.0] Leg height (mm)
const t = 2.0;
let p = box_from_corners([0, 0, 0], [122.0, 80.0, t]);
let holes = [];
for c in 0..12 { for r in 0..8 { holes.push(cylinder([11.5 + 9.0 * c.to_float(), 8.5 + 9.0 * r.to_float(), -1.0], "Z", hole / 2.0, t + 2.0)); } }
let legs = [];
for x in [0.0, 117.0] { for y in [0.0, 75.0] { legs.push(box_from_corners([x, y, -leg], [x + 5.0, y + 5.0, 0.01])); } }
p - fuse_all(holes) + fuse_all(legs)
