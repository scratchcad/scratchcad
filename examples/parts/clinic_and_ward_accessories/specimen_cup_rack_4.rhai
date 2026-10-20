// Clinic urine specimen cup rack: holds four 60 mm specimen cups in a 2 x 2 grid at 70 mm pitch, 150 x 150 mm deck 3 mm thick on four 45 mm legs, with a 3 mm base plate and 30 mm cup seats
let cup_d = 60.0; // [45.0, 75.0] Cup diameter (mm)
let height = 45.0; // [30.0, 70.0] Deck height (mm)
let gap = 10.0; // [6.0, 20.0] Gap between cups (mm)
const t = 3.0;
let pitch = cup_d + gap;
let side = 2.0 * pitch + 10.0;
let r = box_from_corners([0, 0, height - t], [side, side, height]) + box_from_corners([0, 0, 0], [side, side, t]);
let legs = [];
for x in [0.0, side - 10.0] {
    for y in [0.0, side - 10.0] { legs.push(box_from_corners([x, y, t - 0.01], [x + 10.0, y + 10.0, height - t + 0.01])); }
}
r = r + fuse_all(legs);
let holes = [];
for i in 0..2 {
    for j in 0..2 {
        holes.push(cylinder([5.0 + pitch * (i.to_float() + 0.5), 5.0 + pitch * (j.to_float() + 0.5), height - t - 1.0], "Z", cup_d / 2.0 + 1.0, t + 2.0));
        holes.push(cylinder([5.0 + pitch * (i.to_float() + 0.5), 5.0 + pitch * (j.to_float() + 0.5), t - 1.0], "Z", cup_d / 2.0 - 5.0, 2.0));
    }
}
r - compound(holes)
