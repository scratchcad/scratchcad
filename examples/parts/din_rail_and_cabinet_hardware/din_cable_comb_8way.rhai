// DIN rail cable comb, 8 ways: clip foot for the TS35 rail's 35 mm flanges, 30 mm riser and a 3 mm comb 15 mm deep with eight 6 mm cable slots on a 9 mm pitch and 1 mm lead-in chamfers
let ways = 8; // [2, 16] Number of cable slots
let slot_w = 6.0; // [3.0, 10.0] Slot width (mm)
let rise = 30.0; // [15.0, 60.0] Comb height above the rail (mm)
const t = 3.0;
const depth = 15.0;
const lip = 2.3;
let pitch = slot_w + 3.0;
let comb_len = ways.to_float() * pitch + 3.0;
let foot = face(polygon([
    [0, -19.5, -lip], [0, -15.5, -lip], [0, -15.5, -1.2], [0, -17.7, -1.2], [0, -17.7, 0],
    [0, 17.7, 0], [0, 17.7, -1.2], [0, 15.5, -1.2], [0, 15.5, -lip], [0, 19.5, -lip],
    [0, 19.5, 4.0], [0, -19.5, 4.0]])).extrude([10.0, 0, 0]).translate([-5.0, 0, 0]);
let riser = box_from_corners([-5.0, -19.5, 3.5], [5.0, -19.5 + t, rise]);
let comb = box_from_corners([-comb_len / 2.0, -19.5, rise - t], [comb_len / 2.0, -19.5 + depth, rise]);
let slots = [];
for i in 0..ways {
    let x = -comb_len / 2.0 + 3.0 + pitch * i.to_float() + slot_w / 2.0;
    slots.push(box_from_corners([x - slot_w / 2.0, -19.5 + 5.0, rise - t - 1.0], [x + slot_w / 2.0, -19.5 + depth + 1.0, rise + 1.0]));
}
foot + riser + comb - fuse_all(slots)
