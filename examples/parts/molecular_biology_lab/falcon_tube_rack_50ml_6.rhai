// 50 ml conical tube rack, 6 place: 30.5 mm holes on a 38 mm pitch in a 2 x 3 grid, 3 mm top deck 60 mm above a 10 mm base with conical cups 8 mm deep for the tube tips, joined by 4 mm end walls
let hole = 30.5; // [29.5, 32.0] Tube hole diameter (mm)
let height = 60.0; // [40.0, 90.0] Deck height (mm)
const pitch = 38.0;
const t = 3.0;
let w = pitch * 3.0 + 8.0;
let d = pitch * 2.0 + 8.0;
let deck = box_from_corners([0, 0, height], [w, d, height + t]);
let base = box_from_corners([0, 0, 0], [w, d, 10.0]);
let ends = box_from_corners([0, 0, 0], [4.0, d, height + 0.01]) + box_from_corners([w - 4.0, 0, 0], [w, d, height + 0.01]);
let holes = [];
let cups = [];
for i in 0..3 { for j in 0..2 {
    let x = 4.0 + pitch * (i.to_float() + 0.5);
    let y = 4.0 + pitch * (j.to_float() + 0.5);
    holes.push(cylinder([x, y, height - 1.0], "Z", hole / 2.0, t + 2.0));
    cups.push(cone(6.0, 12.0, 8.01).translate([x, y, 2.0]));
} }
deck + base + ends - fuse_all(holes) - fuse_all(cups)
