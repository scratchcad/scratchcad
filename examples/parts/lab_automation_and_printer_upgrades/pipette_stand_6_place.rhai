// Linear stand for 6 single-channel pipettes: 270 x 90 mm base 6 mm, two 220 mm uprights, 270 x 50 mm top bar 6 mm with 6 keyhole slots (14 mm neck, 22 mm seat) on 42 mm pitch
let places = 6; // [2, 10] Number of pipette places
let pitch = 42.0; // [32.0, 60.0] Pipette spacing (mm)
let height = 220.0; // [150.0, 300.0] Hanger bar height (mm)
let neck = 14.0; // [10.0, 18.0] Slot neck width (mm)
const t = 6.0;
const bar_d = 50.0;
let length = places.to_float() * pitch + 18.0;
let base = box_from_corners([0, 0, 0], [length, 90.0, t]);
base = base.fillet(8.0, "|Z");
let uprights = [];
for x in [0.0, length - t] {
    uprights.push(box_from_corners([x, 70.0, t - 1.0], [x + t, 90.0, height + t]));
}
let bar = box_from_corners([0, 90.0 - bar_d, height], [length, 90.0, height + t]);
let seat = min(min(22.0, neck + 8.0), pitch - 8.0);
let n = min(neck, seat - 2.0);
let slots = [];
for i in 0..places {
    let x = 9.0 + pitch * (i.to_float() + 0.5);
    let y_seat = 90.0 - bar_d + 22.0;
    slots.push(fuse_all([cylinder([x, y_seat, height - 1.0], "Z", seat / 2.0, t + 2.0), box_from_corners([x - n / 2.0, 90.0 - bar_d - 1.0, height - 1.0], [x + n / 2.0, y_seat, height + t + 1.0])]));
}
fuse_all([base, bar] + uprights) - compound(slots)
