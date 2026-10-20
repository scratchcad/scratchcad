// Tube-style belay device: 60 x 45 mm body 30 mm deep with two 11 x 30 mm rope slots for 8.5-11 mm ropes, 3 mm walls, flared rope ends and a 20 x 8 mm keeper-wire slot
let slot_w = 11.0; // [9.0, 13.0] Rope slot width (mm)
let depth = 30.0; // [24.0, 40.0] Body depth (mm)
const wall = 3.0;
const slot_l = 30.0;
let body = box_from_corners([-30.0, -22.5, 0], [30.0, 22.5, depth]);
let body = body.fillet(6.0, body.edges("|Z"));
let slots = [];
for sx in [-1.0, 1.0] { slots.push(box_from_corners([sx * (wall / 2.0 + slot_w / 2.0) - slot_w / 2.0, -slot_l / 2.0, -1.0], [sx * (wall / 2.0 + slot_w / 2.0) + slot_w / 2.0, slot_l / 2.0, depth + 1.0])); }
let flare = box_from_corners([-wall / 2.0 - slot_w - 2.0, -slot_l / 2.0 - 2.0, depth - 4.0], [wall / 2.0 + slot_w + 2.0, slot_l / 2.0 + 2.0, depth + 1.0]);
let keeper = box_from_corners([-10.0, 15.0, depth - 12.0], [10.0, 30.0, depth - 4.0]);
body - fuse_all(slots) - flare - keeper
