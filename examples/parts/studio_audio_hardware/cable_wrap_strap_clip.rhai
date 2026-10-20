// Audio cable coil keeper: 120 x 20 x 2 mm strap with 15 adjustment holes of 4 mm on 6 mm centres and a 10 x 8 mm mushroom stud at one end
let length = 120.0; // [80.0, 200.0] Strap length (mm)
let holes = 15; // [6, 25] Number of adjustment holes
const t = 2.0;
const w = 20.0;
let s = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, t]) + cylinder([0, 0, 0], "Z", w / 2.0, t) + cylinder([length, 0, 0], "Z", w / 2.0, t);
let cuts = [];
for i in 0..holes { cuts.push(cylinder([length - 6.0 - i.to_float() * 6.0, 0, -1.0], "Z", 2.0, t + 2.0)); }
let stud = cylinder([0, 0, t - 0.01], "Z", 2.0, 4.0) + cylinder([0, 0, t + 3.99], "Z", 4.0, 2.0);
s - fuse_all(cuts) + stud
