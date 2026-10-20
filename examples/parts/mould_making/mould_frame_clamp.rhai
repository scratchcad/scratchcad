// Two-part mould frame clamp: 60 mm C-clamp 20 mm wide, 8 mm thick, opening 45 mm, with an M6 tapped screw boss (5 mm drill) and a 15 mm pressure pad pocket
let opening = 45.0; // [25.0, 80.0] Clamp opening (mm)
let depth = 30.0; // [20.0, 50.0] Throat depth (mm)
const t = 8.0;
const w = 20.0;
let c = box_from_corners([0, 0, 0], [depth + t, w, t]) + box_from_corners([0, 0, opening + t], [depth + t, w, opening + 2.0 * t]) + box_from_corners([depth, 0, 0], [depth + t, w, opening + 2.0 * t]);
let boss = cylinder([depth * 0.4, w / 2.0, opening + 2.0 * t - 0.01], "Z", 6.0, 6.0);
c + boss - cylinder([depth * 0.4, w / 2.0, opening + t - 1.0], "Z", 2.5, t + 10.0) - cylinder([depth * 0.4, w / 2.0, t - 2.0], "Z", 7.5, 3.0)
