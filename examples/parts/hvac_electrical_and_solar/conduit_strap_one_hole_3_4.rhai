// One-hole steel strap for 3/4 in EMT (23.4 mm OD): 1.6 mm thick, 19 mm wide band, single 30 mm foot with a 6.5 mm screw hole
let conduit_od = 23.4; // [12.0, 60.0] Conduit outside diameter (mm)
let band_w = 19.0; // [12.0, 30.0] Band width (mm)
let foot_len = 30.0; // [20.0, 45.0] Foot length (mm)
const t = 1.6;
let ri = conduit_od / 2.0;
let ring = cylinder([0, -band_w / 2.0, 0], "Y", ri + t, band_w) - cylinder([0, -band_w, 0], "Y", ri, band_w * 2.0);
let band = ring & box_from_corners([-ri - t - 1.0, -band_w, 0], [ri + t + 1.0, band_w, ri + t + 1.0]);
let lower = ring & box_from_corners([-ri - t - 1.0, -band_w, -ri - t - 1.0], [0, band_w, 0]) & box_from_corners([-ri - t - 1.0, -band_w, -ri * 0.2], [ri, band_w, 0.1]);
let leg = box_from_corners([ri, -band_w / 2.0, -ri - t], [ri + t, band_w / 2.0, 0.1]);
let foot = box_from_corners([ri, -band_w / 2.0, -ri - t], [ri + foot_len, band_w / 2.0, -ri]);
let s = fuse_all([band, lower, leg, foot]);
s - cylinder([ri + foot_len * 0.55, 0, -ri - 5.0], "Z", 3.25, 10.0)
