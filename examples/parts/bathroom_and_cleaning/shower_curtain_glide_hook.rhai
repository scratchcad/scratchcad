// Shower curtain glide hook for a 25 mm (1 in) rod: 12 mm wide, 3 mm thick C-hook, 30 mm stem, 7 mm J-hook for the curtain eyelet
let rod_d = 25.0; // [19.0, 32.0] Rod diameter (mm)
let width = 12.0; // [8.0, 16.0] Hook width (mm)
let t = 3.0; // [2.0, 4.0] Material thickness (mm)
let stem = 30.0; // [20.0, 45.0] Stem length (mm)
let ri = rod_d / 2.0 + 1.0;
let ro = ri + t;
let top = cylinder([0, 0, 0], "Y", ro, width) - cylinder([0, -1, 0], "Y", ri, width + 2.0) - box_from_corners([0, -1, 0], [ro + 1.0, width + 1.0, ro + 1.0]);
let zb = -ro - stem;
let s = box_from_corners([-t / 2.0, 0, zb + 2.0], [t / 2.0, width, -ri - 0.5 * t]);
const hr = 3.5;
let hx = hr + t / 2.0 + 0.5;
let lower = cylinder([hx, 0, zb], "Y", hr + t, width) - cylinder([hx, -1, zb], "Y", hr, width + 2.0) - box_from_corners([hx, -1, zb], [hx + hr + t + 1.0, width + 1.0, zb + hr + t + 1.0]);
top + s + lower
