// Hydroponic 3 inch net pot: 76 mm inside at the rim, 75 mm tall, tapering to a 56 mm base, 1.8 mm wall, a 7 mm rim lip 2.5 mm thick, two staggered rows of 16 side windows with a 6 mm band between them, and a 2.5 mm floor with a centre drain hole and six round holes
let top_d = 76.0; // [60.0, 100.0] Inside diameter at the rim (mm)
let height = 75.0; // [55.0, 110.0] Pot height (mm)
let windows = 16; // [8, 24] Number of windows per row
let floor_hole_d = 8.0; // [4.0, 12.0] Floor hole diameter (mm)
const wall = 1.8;
const floor_t = 2.5;
const lip_w = 7.0;
const lip_t = 2.5;
const band = 6.0;
let rt = top_d / 2.0 + wall;
let rb = rt * 0.74;
let profile = polygon([
    [0, 0, 0], [rb, 0, 0], [rt, 0, height - lip_t], [rt + lip_w, 0, height - lip_t], [rt + lip_w, 0, height],
    [rt - wall, 0, height], [rb - wall, 0, floor_t], [0, 0, floor_t]]);
let pot = face(profile).revolve("Z", 360.0);
let n = windows.to_float();
let ww = 0.5 * 2.0 * PI() * (rb - wall) / n;
let zs = floor_t + 4.0;
let ze = height - lip_t - 5.0;
let zm = (zs + ze) / 2.0;
let cuts = [];
for i in 0..windows {
    let a = i.to_float() * 360.0 / n;
    cuts.push(box_from_corners([rb - wall - 5.0, -ww / 2.0, zs], [rt + 2.0, ww / 2.0, zm - band / 2.0]).rotate_z(a));
    cuts.push(box_from_corners([rb - wall - 5.0, -ww / 2.0, zm + band / 2.0], [rt + 2.0, ww / 2.0, ze]).rotate_z(a + 180.0 / n));
}
let fr = min(floor_hole_d / 2.0, (rb - wall) / 5.0);
cuts.push(cylinder([0, 0, -1.0], "Z", fr, floor_t + 2.0));
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    let pr = (rb - wall) * 0.6;
    cuts.push(cylinder([pr * cos(a), pr * sin(a), -1.0], "Z", fr, floor_t + 2.0));
}
pot - fuse_all(cuts)
