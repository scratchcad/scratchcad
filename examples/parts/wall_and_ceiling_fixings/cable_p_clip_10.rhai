// Cable P-clip for a 10 mm bundle: 12 mm wide, 1.5 mm strap looped to 10 mm ID, tab 15 mm long with a 5.3 mm hole, tab ends overlapped
let bundle = 10.0; // [5.0, 25.0] Bundle diameter (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
const t = 1.5;
let r = bundle / 2.0;
let loop_ = cylinder([0, 0, r + t], "Y", r + t, width) - cylinder([0, -1.0, r + t], "Y", r, width + 2.0);
let tab = box_from_corners([0, 0, 0], [r + 15.0, width, t]) + box_from_corners([0, 0, t - 0.01], [r + 15.0, width, 2.0 * t]);
let c = loop_ + tab - box_from_corners([-0.01, -1.0, t], [r * 0.6, width + 1.0, r + t]);
c - cylinder([r + 9.0, width / 2.0, -1.0], "Z", 2.65, 2.0 * t + 2.0)
