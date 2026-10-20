// TS15 miniature top-hat rail, 100 mm long: 15 mm over the flanges, 5.5 mm tall, 1 mm steel, 9 mm crown with 4.2 x 10 mm fixing slots on a 25 mm pitch
let length = 100.0; // [25.0, 500.0] Rail length (mm)
let slot_pitch = 25.0; // [15.0, 50.0] Slot pitch (mm)
const t = 1.0;
const h = 5.5;
let profile = polygon([
    [0, -4.5, 0], [0, 4.5, 0], [0, 4.5, h - t], [0, 7.5, h - t], [0, 7.5, h], [0, 3.5, h],
    [0, 3.5, t], [0, -3.5, t], [0, -3.5, h], [0, -7.5, h], [0, -7.5, h - t], [0, -4.5, h - t]]);
let rail = face(profile).extrude([length, 0, 0]);
let n = (length / slot_pitch).to_int();
let slots = [];
for i in 0..n {
    let x = length / 2.0 + (i.to_float() - (n.to_float() - 1.0) / 2.0) * slot_pitch;
    slots.push(box_centered(10.0 - 4.2, 4.2, 4.0).translate([x, 0, 0.5])
        + cylinder([x - 2.9, 0, -1.5], "Z", 2.1, 4.0) + cylinder([x + 2.9, 0, -1.5], "Z", 2.1, 4.0));
}
if n > 0 { rail - fuse_all(slots) } else { rail }
