// Sawtooth picture hanger: 45 x 8 x 0.8 mm strip with 13 teeth 1.5 mm deep along the bottom edge and two 1.5 mm nail holes 35 mm apart
let length = 45.0; // [30.0, 80.0] Hanger length (mm)
let teeth = 13; // [7, 25] Number of teeth
const t = 0.8;
let s = box_from_corners([0, 0, 0], [length, 8.0, t]);
let p = (length - 10.0) / teeth.to_float();
let cuts = [cylinder([5.0, 5.5, -1.0], "Z", 0.75, t + 2.0), cylinder([length - 5.0, 5.5, -1.0], "Z", 0.75, t + 2.0)];
for i in 0..teeth { let x = 5.0 + p * i.to_float(); cuts.push(face(polygon([[x, -0.01, -1.0], [x + p, -0.01, -1.0], [x + p, 1.5, -1.0]])).extrude([0, 0, t + 2.0])); }
s - fuse_all(cuts)
