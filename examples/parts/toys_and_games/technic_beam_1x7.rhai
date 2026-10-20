// LEGO Technic-compatible 7-hole liftarm: 8 mm pitch, 7.2 mm thick, 4.8 mm pin holes with 6.2 mm counterbores 0.8 mm deep, rounded ends
let holes = 7; // [2, 15] Holes
let len = (holes - 1).to_float() * 8.0;
let beam = box_from_corners([0, -3.6, 0], [len, 3.6, 7.2]) + cylinder([0, 0, 0], "Z", 3.6, 7.2) + cylinder([len, 0, 0], "Z", 3.6, 7.2);
let cuts = [];
for i in 0..holes {
    let x = i.to_float() * 8.0;
    cuts.push(cylinder([x, 0, -1], "Z", 2.4, 9.2));
    cuts.push(cylinder([x, 0, -1], "Z", 3.1, 1.8));
    cuts.push(cylinder([x, 0, 6.4], "Z", 3.1, 1.8));
}
beam.rotate_x(90.0) - fuse_all(cuts).rotate_x(90.0)
