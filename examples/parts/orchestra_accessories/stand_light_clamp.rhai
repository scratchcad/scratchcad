// Music stand light clamp: clamps a 10 mm stand desk lip up to 12 mm, 30 mm wide jaw 4 mm thick with an M5 thumbscrew boss and a 10 mm gooseneck socket 15 mm deep on top
let lip = 12.0; // [6.0, 20.0] Max lip thickness (mm)
let neck = 10.0; // [8.0, 14.0] Gooseneck diameter (mm)
const t = 4.0;
const w = 30.0;
let c = box_from_corners([0, 0, 0], [t, w, 25.0]) + box_from_corners([0, 0, 25.0 - t], [lip + 2.0 * t, w, 25.0]) + box_from_corners([lip + t, 0, 0], [lip + 2.0 * t, w, 25.0]);
let boss = cylinder([lip + 2.0 * t - 0.01, w / 2.0, 8.0], "X", 5.0, 6.0);
let socket = cylinder([(lip + 2.0 * t) / 2.0, w / 2.0, 25.0 - 0.01], "Z", neck / 2.0 + 3.0, 15.0) - cylinder([(lip + 2.0 * t) / 2.0, w / 2.0, 25.0], "Z", neck / 2.0 + 0.2, 16.0);
c + boss + socket - cylinder([lip, w / 2.0, 8.0], "X", 2.1, 2.0 * t + 8.0)
