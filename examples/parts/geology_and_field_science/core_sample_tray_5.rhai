// Drill core sample tray: 5 channels for 47.6 mm NQ core, 500 mm long, 55 mm channel pitch, 3 mm dividers, 35 mm deep with closed ends and an 80 x 10 mm hand slot in each end wall
let length = 500.0; // [300.0, 1000.0] Tray length (mm)
let core = 47.6; // [36.0, 63.5] Core diameter (mm)
let channels = 5; // [3, 8] Number of channels
const wall = 3.0;
const depth = 35.0;
let pitch = core + 7.0;
let w = channels.to_float() * pitch + wall;
let tray = box_from_corners([0, 0, 0], [length + 2.0 * wall, w, depth]);
let cuts = [];
for i in 0..channels {
    let y = wall + pitch * i.to_float() + (pitch - wall) / 2.0;
    cuts.push(box_from_corners([wall, y - (pitch - wall) / 2.0, wall], [length + wall, y + (pitch - wall) / 2.0, depth + 1.0]));
}
let slots = box_from_corners([-1.0, w / 2.0 - 40.0, depth - 15.0], [wall + 1.0, w / 2.0 + 40.0, depth - 5.0]) + box_from_corners([length + wall - 1.0, w / 2.0 - 40.0, depth - 15.0], [length + 2.0 * wall + 1.0, w / 2.0 + 40.0, depth - 5.0]);
tray - fuse_all(cuts) - slots
