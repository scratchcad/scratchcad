// Medical gas cylinder valve key: 90 x 22 mm flat key 6 mm thick with rounded ends, an 8 mm square drive at one end and a 6.5 mm square drive at the other for pin-index valve spindles, and a 6 mm lanyard hole
let length = 90.0; // [70.0, 130.0] Key length (mm)
let big_sq = 8.0; // [7.0, 10.0] Large square drive (mm)
let small_sq = 6.5; // [5.0, 7.0] Small square drive (mm)
const w = 22.0;
const t = 6.0;
let k = box_centered(length, w, t);
k = k.fillet(w / 2.0 - 0.5, k.edges("|Z"));
let sq1 = box_centered(big_sq + 0.2, big_sq + 0.2, t + 2.0).rotate_z(45.0).translate([-length / 2.0 + w / 2.0, 0, 0]);
let sq2 = box_centered(small_sq + 0.2, small_sq + 0.2, t + 2.0).rotate_z(45.0).translate([length / 2.0 - w / 2.0, 0, 0]);
k - sq1 - sq2 - cylinder([0, 0, -t], "Z", 3.0, 2.0 * t)
