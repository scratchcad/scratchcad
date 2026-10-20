// Mic stand clutch: twist-lock clutch collar for a 22 mm tube, 40 mm OD x 30 mm, 18 grip ribs, 3/4 in internal thread modelled as 1.5 mm ridges at 2 mm pitch, 12 degree split collet cone inside
let tube = 22.0; // [16.0, 28.0] Tube diameter (mm)
let od = 40.0; // [32.0, 50.0] Clutch diameter (mm)
let height = 30.0; // [20.0, 40.0] Clutch height (mm)
let ribs = 18; // [8, 30] Number of grip ribs
let thread_d = tube + 7.0;
let r = od / 2.0;
let body = polygon("XZ", [[tube / 2.0 + 0.3, 0], [r - 1.0, 0], [r, 1.0], [r, height - 1.0], [r - 1.0, height], [tube / 2.0 + 0.3, height]]).to_face().revolve([0, 0, 0], "Z", 360);
// inner cavity: threaded section at the bottom, cone for the collet above
let cav = polygon("XZ", [[0, -1.0], [thread_d / 2.0, -1.0], [thread_d / 2.0, height * 0.5], [tube / 2.0 + 0.3, height - 4.0], [0, height - 4.0]]).to_face().revolve([0, 0, 0], "Z", 360);
let ridges = [];
let n = (height * 0.5 / 2.0).floor().to_int();
for i in 0..n { ridges.push(cylinder([0, 0, 1.0 + i.to_float() * 2.0], "Z", thread_d / 2.0 + 0.01, 0.8) - cylinder([0, 0, i.to_float() * 2.0], "Z", thread_d / 2.0 - 1.5, 3.0)); }
let grip = [];
for k in 0..ribs { grip.push(cylinder([r + 0.4, 0, 3.0], "Z", 1.2, height - 6.0).rotate_z(k.to_float() * 360.0 / ribs.to_float())); }
(body - cav + fuse_all(ridges)) - compound(grip)
