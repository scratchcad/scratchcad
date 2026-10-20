// Pond / aquaponics UV steriliser body clamp for a 50 mm housing: 4 mm C clip 20 mm wide with a 50.6 mm bore and a 40 mm front opening, on a 10 mm thick mounting pad 60 mm long with two 4.5 mm screw holes and 8 mm counterbores from the clip side
let body_d = 50.0; // [30.0, 90.0] Steriliser body diameter (mm)
let width = 20.0; // [12.0, 35.0] Clip width (mm)
let opening = 0.8; // [0.6, 0.9] Opening as a fraction of the diameter
const wall = 4.0;
const pad_t = 10.0;
let ri = body_d / 2.0 + 0.3;
let ro = ri + wall;
let ring = cylinder([0, 0, 0], "Z", ro, width) - cylinder([0, 0, -1.0], "Z", ri, width + 2.0);
let gw = opening * body_d;
let clip = ring - box_from_corners([-gw / 2.0, 0, -1.0], [gw / 2.0, ro + 1.0, width + 1.0]);
let pl = max(60.0, 2.0 * ro + 10.0);
let pad = box_from_corners([-pl / 2.0, -ri - pad_t, 0], [pl / 2.0, -ri + 0.5, width]);
let body = (clip + pad) - cylinder([0, 0, -1.0], "Z", ri, width + 2.0);
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * (pl / 2.0 - 7.0);
    cuts.push(cylinder([x, -ri - pad_t - 1.0, width / 2.0], "Y", 2.25, pad_t + 3.0));
    cuts.push(cylinder([x, -ri - pad_t + 4.0, width / 2.0], "Y", 4.0, pad_t));
}
body - fuse_all(cuts)
