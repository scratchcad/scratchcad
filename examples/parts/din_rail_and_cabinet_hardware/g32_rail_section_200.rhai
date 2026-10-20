// G32 (EN 50035) G-section mounting rail, 200 mm long: 32 mm wide, 15 mm tall, 1.5 mm steel, 5 mm deep lip on one side and 3 mm on the other, 5.3 x 15 mm fixing slots every 50 mm
let length = 200.0; // [50.0, 600.0] Rail length (mm)
let slot_pitch = 50.0; // [25.0, 100.0] Slot pitch (mm)
const t = 1.5;
const w = 32.0;
const h = 15.0;
let a = w / 2.0;
let profile = polygon([
    [0, -a, 0], [0, a, 0], [0, a, h], [0, a - 5.0, h], [0, a - 5.0, h - t], [0, a - t, h - t],
    [0, a - t, t], [0, -a + t, t], [0, -a + t, h - 4.0], [0, -a + 3.0, h - 4.0],
    [0, -a + 3.0, h - 4.0 + t], [0, -a, h - 4.0 + t]]);
let rail = face(profile).extrude([length, 0, 0]);
let n = (length / slot_pitch).to_int();
let slots = [];
for i in 0..n {
    let x = length / 2.0 + (i.to_float() - (n.to_float() - 1.0) / 2.0) * slot_pitch;
    slots.push(box_centered(15.0 - 5.3, 5.3, 4.0).translate([x, 0, 0.5])
        + cylinder([x - 4.85, 0, -1.5], "Z", 2.65, 4.0) + cylinder([x + 4.85, 0, -1.5], "Z", 2.65, 4.0));
}
if n > 0 { rail - fuse_all(slots) } else { rail }
