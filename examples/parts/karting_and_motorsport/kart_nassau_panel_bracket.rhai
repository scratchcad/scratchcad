// Kart nassau panel upper bracket: 4 mm base 25 mm wide with a U cradle for a 20 mm steering support tube (3 mm wall, open on top) and an M6 hole (6.4 mm) under the tube, and a tongue running 60 mm forward with two M6 holes (6.4 mm) 30 mm apart for the front fairing
let tube_d = 20.0; // [16.0, 25.0] Support tube diameter (mm)
let tongue_len = 60.0; // [45.0, 90.0] Tongue length (mm)
let width = 25.0; // [20.0, 35.0] Bracket width (mm)
const wall = 3.0;
const base_t = 4.0;
let ri = tube_d / 2.0 + 0.2;
let ro = ri + wall;
let zc = base_t + ri - 1.0;
let cradle = cylinder([0, -width / 2.0, zc], "Y", ro, width) + box_from_corners([-ro, -width / 2.0, zc], [ro, width / 2.0, zc + ri]);
let base = box_from_corners([-ro, -width / 2.0, 0], [ro + tongue_len, width / 2.0, base_t]);
let base = base.fillet(4.0, base.edges("|Z and >X"));
let body = cradle + base;
let cuts = [
    cylinder([0, -width / 2.0 - 1.0, zc], "Y", ri, width + 2.0),
    box_from_corners([-ri, -width / 2.0 - 1.0, zc], [ri, width / 2.0 + 1.0, zc + ro + 1.0]),
    cylinder([0, 0, -1.0], "Z", 3.2, base_t + 2.0)
];
for i in 0..2 {
    cuts.push(cylinder([ro + tongue_len - 10.0 - i.to_float() * 30.0, 0, -1.0], "Z", 3.2, base_t + 2.0));
}
body - fuse_all(cuts)
