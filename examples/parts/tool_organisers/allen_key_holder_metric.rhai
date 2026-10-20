// Metric Allen key holder: stepped block for 1.5, 2, 2.5, 3, 4, 5, 6, 8 and 10 mm hex keys, 0.3 mm clearance round holes 20 mm deep, 130 x 25 mm footprint rising from 15 to 30 mm
let depth = 20.0; // [12.0, 30.0] Hole depth (mm)
let length = 130.0; // [110.0, 180.0] Block length (mm)
const w = 25.0;
let keys = [1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0];
let block = face(polygon([[0, 0, 0], [length, 0, 0], [length, 0, 30.0], [0, 0, 15.0]])).extrude([0, w, 0]);
let total = keys.reduce(|sum, k| sum + (k + 0.3) / cos(PI() / 6.0) + 0.4 + 3.5, 0.0) - 3.5;
let holes = [];
let x = (length - total) / 2.0;
for k in keys {
    let af = k + 0.3;
    let r = af / cos(PI() / 6.0) / 2.0 + 0.2;
    holes.push(cylinder([x + r, w / 2.0, -1.0], "Z", r, 40.0) & box_from_corners([x - 1.0, 0, 30.0 - depth - (length - x) * 15.0 / length], [x + 2.0 * r + 1.0, w, 40.0]));
    x += 2.0 * r + 3.5;
}
block - fuse_all(holes)
