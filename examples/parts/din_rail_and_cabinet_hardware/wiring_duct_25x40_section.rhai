// Slotted wiring duct 25 x 40 mm, 100 mm section: 1.6 mm PVC walls, 4.2 mm finger slots on a 12 mm pitch down to 8 mm above the floor, 4.5 mm fixing holes in the floor every 50 mm
let length = 100.0; // [48.0, 300.0] Section length (mm)
let width = 25.0; // [15.0, 80.0] Duct width (mm)
let height = 40.0; // [25.0, 100.0] Duct height (mm)
let slot_pitch = 12.0; // [8.0, 20.0] Slot pitch (mm)
const wall = 1.6;
const slot_w = 4.2;
let duct = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height])
    - box_from_corners([-1.0, -width / 2.0 + wall, wall], [length + 1.0, width / 2.0 - wall, height + 1.0]);
let n = ((length - slot_w) / slot_pitch).to_int();
let cuts = [];
for i in 0..n {
    let x = slot_pitch / 2.0 + i.to_float() * slot_pitch + (length - n.to_float() * slot_pitch) / 2.0;
    cuts.push(box_from_corners([x - slot_w / 2.0, -width, 8.0], [x + slot_w / 2.0, width, height + 1.0]));
}
let m = (length / 50.0).to_int();
for j in 0..m {
    let x = length / 2.0 + (j.to_float() - (m.to_float() - 1.0) / 2.0) * 50.0;
    cuts.push(cylinder([x, 0, -1.0], "Z", 2.25, wall + 2.0));
}
duct - fuse_all(cuts)
