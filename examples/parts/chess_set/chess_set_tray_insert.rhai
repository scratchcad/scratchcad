// Chess box tray insert: 16 pockets in a 2 x 8 grid for one side's pieces, 42 mm pockets on 45 mm pitch, 25 mm deep, 3 mm floor, 370 x 100 mm overall
let pitch = 45.0; // [36.0, 55.0] Pocket pitch (mm)
let depth = 25.0; // [15.0, 40.0] Pocket depth (mm)
const floor_t = 3.0;
let w = pitch * 8.0 + 10.0;
let h = pitch * 2.0 + 10.0;
let tray = box_from_corners([0, 0, 0], [w, h, depth + floor_t]);
let pockets = [];
for i in 0..8 { for j in 0..2 { pockets.push(cylinder([5.0 + pitch * (i.to_float() + 0.5), 5.0 + pitch * (j.to_float() + 0.5), floor_t], "Z", pitch / 2.0 - 1.5, depth + 1.0)); } }
let finger = box_from_corners([w / 2.0 - 20.0, -1.0, depth + floor_t - 8.0], [w / 2.0 + 20.0, 6.0, depth + floor_t + 1.0]);
tray - fuse_all(pockets) - finger
