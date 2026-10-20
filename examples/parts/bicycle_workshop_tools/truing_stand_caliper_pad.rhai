// Truing stand caliper pad: 34 x 12 x 8 mm nylon block, 6.2 mm adjustment slot 14 mm long, pointed nose with a 45 degree bevel each side and a 1 mm flat tip touching the rim
let length = 34.0; // [26.0, 45.0] Pad length (mm)
let width = 12.0; // [10.0, 16.0] Pad width (mm)
let thickness = 8.0; // [5.0, 12.0] Pad thickness (mm)
let slot_len = 14.0; // [8.0, 18.0] Slot length (mm)
const slot_w = 6.2;
let nose = width / 2.0 - 0.5;
let plan = polygon([
    [0, -width / 2.0, 0], [length - nose, -width / 2.0, 0], [length, -0.5, 0],
    [length, 0.5, 0], [length - nose, width / 2.0, 0], [0, width / 2.0, 0]
]);
let pad = plan.to_face().extrude([0, 0, thickness]);
let slot = fuse_all([
    box_from_corners([4.0 + slot_w / 2.0, -slot_w / 2.0, -1.0], [4.0 + slot_w / 2.0 + slot_len - slot_w, slot_w / 2.0, thickness + 1.0]),
    cylinder([4.0 + slot_w / 2.0, 0, -1.0], "Z", slot_w / 2.0, thickness + 2.0),
    cylinder([4.0 + slot_w / 2.0 + slot_len - slot_w, 0, -1.0], "Z", slot_w / 2.0, thickness + 2.0),
]);
pad - slot
