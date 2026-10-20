// Racking cane bucket clip: clamps a 9.5 mm cane to a fermenter rim up to 4 mm thick, 15 mm wide, with a 22 mm deep rim hook and a C-clip for the cane
let cane = 9.5; // [6.0, 12.7] Cane diameter (mm)
let rim = 4.0; // [2.0, 6.0] Rim thickness (mm)
const w = 15.0;
const t = 2.5;
let hook = box_from_corners([0, 0, 0], [t, w, 22.0]) + box_from_corners([0, 0, 22.0 - 0.01], [2.0 * t + rim, w, 22.0 + t]) + box_from_corners([t + rim, 0, 10.0], [2.0 * t + rim, w, 22.0]);
let cx = -cane / 2.0 - 1.0;
let clip = cylinder([cx, 0, 12.0], "Y", cane / 2.0 + t, w) - cylinder([cx, -1.0, 12.0], "Y", cane / 2.0, w + 2.0) - box_from_corners([cx - cane, -1.0, 12.0 - cane * 0.3], [cx - cane / 2.0 + 1.0, w + 1.0, 12.0 + cane * 0.3]);
hook + clip
