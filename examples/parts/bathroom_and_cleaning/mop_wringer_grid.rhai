// Mop bucket wringer grid: 220 x 120 x 5 mm ribbed plate, 2 rows of 14 drain slots 6 x 45 mm, 2 rim hooks for a 4 mm bucket rim
let width = 220.0; // [160.0, 300.0] Grid width (mm)
let height = 120.0; // [90.0, 180.0] Grid height (mm)
let slots = 14; // [8, 20] Slots per row
let slot_w = 6.0; // [4.0, 10.0] Slot width (mm)
let t = 5.0; // [3.0, 8.0] Plate thickness (mm)
let rim = 4.0; // [2.0, 8.0] Bucket rim thickness (mm)
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height]);
let p = plate.fillet(8.0, plate.edges("|Y"));
let pitch = (width - 30.0) / (slots - 1).to_float();
let sl = (height - 30.0) / 2.0;
let cuts = [];
for i in 0..slots { for row in 0..2 {
    let x = -(width - 30.0) / 2.0 + i.to_float() * pitch;
    let z0 = 10.0 + row.to_float() * (sl + 10.0);
    cuts.push(box_from_corners([x - slot_w / 2.0, -1, z0], [x + slot_w / 2.0, t + 1.0, z0 + sl]));
} }
let ribs = [];
for i in 0..(slots - 1) {
    let x = -(width - 30.0) / 2.0 + (i.to_float() + 0.5) * pitch;
    ribs.push(box_from_corners([x - 1.0, t - 0.5, 10.0], [x + 1.0, t + 4.0, height - 10.0]));
}
let hooks = [];
for x in [-width * 0.35, width * 0.35] {
    hooks.push(box_from_corners([x - 10.0, 0, height - 0.5], [x + 10.0, t, height + 10.0]));
    hooks.push(box_from_corners([x - 10.0, -rim - t, height + 10.0 - t], [x + 10.0, 0.01, height + 10.0]));
    hooks.push(box_from_corners([x - 10.0, -rim - t, height - 5.0], [x + 10.0, -rim, height + 10.0 - t + 0.01]));
}
p + fuse_all(ribs) + fuse_all(hooks) - compound(cuts)
