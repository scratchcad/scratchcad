// Baler twine guide eye: 60 x 26 x 5 mm mounting plate (lengthened if needed to clear the slot) with 13 mm rounded ends and an 8.5 mm wide adjustment slot 14 mm long, and a 22 mm boss standing 8 mm proud at one end with a 10 mm twine eye through it, chamfered 1.5 mm both sides so the twine can't fray
let plate_len = 60.0; // [45.0, 90.0] Plate length (mm)
let plate_w = 26.0; // [20.0, 34.0] Plate width (mm)
let boss_d = 22.0; // [16.0, 30.0] Eye boss diameter (mm)
let boss_h = 8.0; // [4.0, 14.0] Boss height (mm)
let eye_d = 10.0; // [6.0, 14.0] Eye diameter (mm)
const t = 5.0;
const slot_w = 8.5;
const slot_len = 14.0;
let r = plate_w / 2.0;
let bd = max(boss_d, eye_d + 6.0);
let pl = max(plate_len, 3.0 * r + 22.0);
let plate = box_from_corners([0, -r, 0], [pl, r, t]);
let plate = plate.fillet(r - 0.5, plate.edges("|Z"));
let bx = pl - r;
let body = plate + cylinder([bx, 0, t - 0.5], "Z", min(bd / 2.0, r + 2.0), boss_h + 0.5);
let cutters = [cylinder([bx, 0, -1.0], "Z", eye_d / 2.0, t + boss_h + 2.0)];
let sx = r - 2.0;
let sr = slot_w / 2.0;
cutters.push(fuse_all([
    box_from_corners([sx, -sr, -1.0], [sx + slot_len, sr, t + 1.0]),
    cylinder([sx, 0, -1.0], "Z", sr, t + 2.0),
    cylinder([sx + slot_len, 0, -1.0], "Z", sr, t + 2.0),
]));
let eye = body - fuse_all(cutters);
let er = eye_d / 2.0;
eye.chamfer(1.5, eye.edges("%CIRCLE").filter(|e| (e.radius() - er).abs() < 0.01 && e.length() > 6.0 * e.radius()))
