// Desk pen tray with 5 slots: 200 x 110 x 22 mm, five 18 mm round-bottomed pen channels 180 mm long, 3 mm floor under each, 8 mm corner radius, finger scoop at the front
let length = 200.0; // [150.0, 260.0] Tray length (mm)
let slots = 5; // [2, 8] Number of pen slots
let slot_w = 18.0; // [12.0, 26.0] Slot width (mm)
let height = 22.0; // [16.0, 35.0] Tray height (mm)
let divider = 3.0; // [2.0, 5.0] Divider thickness (mm)

const floor_t = 3.0;
const rim = 8.0;
let width = slots * slot_w + (slots - 1) * divider + 2.0 * rim;
let tray = box_from_corners([0, 0, 0], [length, width, height]);
tray = tray.fillet(8.0, tray.edges("|Z"));
tray = tray.fillet(2.0, tray.edges(">Z"));
let r = slot_w / 2.0;
let zc = floor_t + r;
let cuts = [];
for i in 0..slots {
    let y = rim + r + i * (slot_w + divider);
    let ch = cylinder([rim, y, zc], "X", r, length - 2.0 * rim) + box_from_corners([rim, y - r, zc], [length - rim, y + r, height + 1.0]);
    cuts.push(ch);
}
tray = tray - compound(cuts);
tray - cylinder([length / 2.0, -10.0, height + 4.0], "Y", 14.0, rim + 12.0)
