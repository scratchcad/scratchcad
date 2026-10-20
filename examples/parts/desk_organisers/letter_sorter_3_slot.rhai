// Desk letter sorter, 3 slots: 200 mm wide for DL and C5 envelopes, slots 32 mm wide, 4 mm dividers rising from 50 mm at the front to 120 mm at the back, 5 mm floor, sloped side cheeks, finger cut-out in each divider
let width = 200.0; // [150.0, 260.0] Width (mm)
let slots = 3; // [2, 6] Number of letter slots
let slot_w = 32.0; // [20.0, 45.0] Slot width (mm)
let front_h = 50.0; // [30.0, 80.0] Front height (mm)
let back_h = 120.0; // [80.0, 180.0] Back height (mm)

const t = 4.0;
const floor_t = 5.0;
let depth = slots * slot_w + (slots + 1) * t;
let profile = polygon([[0, 0, 0], [0, depth, 0], [0, depth, back_h], [0, depth - t, back_h], [0, 0, front_h]]);
let body = profile.to_face().extrude([width, 0, 0]).translate([-width / 2.0, 0, 0]);
let cuts = [];
for i in 0..slots {
    let y0 = t + i * (slot_w + t);
    cuts.push(box_from_corners([-width / 2.0 + t, y0, floor_t], [width / 2.0 - t, y0 + slot_w, back_h + 1.0]));
}
body = body - compound(cuts);
// step each divider down to a flat top so the slots read like stairs
let tops = [];
for i in 0..=slots {
    let y = i * (slot_w + t);
    let hz = front_h + (back_h - front_h) * i / slots;
    tops.push(box_from_corners([-width / 2.0 + t, y - 0.5, hz], [width / 2.0 - t, y + t + 0.5, back_h + 1.0]));
}
body = body - fuse_all(tops);
let fingers = [];
for i in 0..slots {
    let y = (i + 1) * (slot_w + t);
    let hz = front_h + (back_h - front_h) * (i + 1) / slots;
    fingers.push(cylinder([0, y - 1.0, hz], "Y", 18.0, t + 2.0));
}
fingers.push(cylinder([0, -1.0, front_h], "Y", 18.0, t + 2.0));
body - compound(fingers)
