// Spray bottle S-hook for a cupboard rail: 10 mm wide, 4 mm thick, top C for a 25 mm rail, 40 mm drop, bottom hook for a 16 mm trigger guard
let rail_d = 25.0; // [16.0, 35.0] Rail diameter (mm)
let trigger = 16.0; // [10.0, 24.0] Trigger guard opening (mm)
let drop = 40.0; // [25.0, 70.0] Drop between hooks (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let width = 10.0; // [6.0, 16.0] Width (mm)
let r1 = rail_d / 2.0 + 0.5;
let top = cylinder([0, 0, 0], "Y", r1 + t, width) - cylinder([0, -1, 0], "Y", r1, width + 2.0) - box_from_corners([-r1 - t - 1.0, -1, -1.0], [-r1 * 0.2, width + 1.0, r1 + t + 1.0]).rotate([0, 0, 0], "Y", 30.0);
let r2 = trigger / 2.0;
let zc = -r1 - drop;
let xc = r1 + t / 2.0 - (r2 + t / 2.0);
let shank = box_from_corners([r1, 0, zc], [r1 + t, width, -2.0]);
let bottom = cylinder([xc, 0, zc], "Y", r2 + t, width) - cylinder([xc, -1, zc], "Y", r2, width + 2.0) - box_from_corners([xc - r2 - t - 1.0, -1, zc], [xc, width + 1.0, zc + r2 + t + 1.0]);
let tip = cylinder([xc - r2 - t / 2.0, 0, zc], "Y", t / 2.0, width);
top + shank + bottom + tip
