// Ebb and flow flood table overflow fitting: 40 mm flange 4 mm thick on a 3/4 inch style 26.4 mm shank 25 mm long (ring ridges at 1.814 mm pitch) with a 16 mm bore, and a 22 mm standpipe 50 mm tall above the flange with six 3 mm screen slots 20 mm long near its foot
let flood_depth = 50.0; // [20.0, 100.0] Standpipe height above the flange (mm)
let shank_len = 25.0; // [15.0, 40.0] Shank length (mm)
let flange_d = 40.0; // [34.0, 60.0] Flange diameter (mm)
let screen_slots = 6; // [0, 10] Number of screen slots
const tr = 13.2;
const br = 8.0;
const pr = 11.0;
const ft = 4.0;
const pitch = 1.814;
let rf = max(flange_d / 2.0, tr + 3.0);
let pts = [[br, 0, -shank_len], [tr - 0.6, 0, -shank_len], [tr, 0, -shank_len + 0.6]];
let n = ((shank_len - 3.0) / pitch).floor().to_int();
for i in 0..n {
    pts.push([tr - 0.55, 0, -shank_len + 0.6 + pitch * (i.to_float() + 0.5)]);
    pts.push([tr, 0, -shank_len + 0.6 + pitch * (i.to_float() + 1.0)]);
}
pts.push([tr, 0, 0]);
pts.push([rf, 0, 0]);
pts.push([rf, 0, ft]);
pts.push([pr, 0, ft]);
pts.push([pr, 0, ft + flood_depth]);
pts.push([br, 0, ft + flood_depth]);
let body = face(polygon(pts)).revolve("Z", 360.0);
let cuts = [];
let sl = min(20.0, flood_depth - 8.0);
for i in 0..screen_slots {
    cuts.push(box_from_corners([br - 1.0, -1.5, ft + 3.0], [pr + 1.0, 1.5, ft + 3.0 + sl]).rotate_z(i.to_float() * 360.0 / screen_slots.to_float()));
}
if screen_slots > 0 { body - fuse_all(cuts) } else { body }
