// T-track hold-down clamp bar: 120 x 25 x 12 mm bar, 8 x 70 mm slot for a 1/4 in T-bolt, 8 mm toe with a rounded nose and 8 mm heel underneath
let length = 120.0; // [80.0, 200.0] Bar length (mm)
let width = 25.0; // [18.0, 35.0] Bar width (mm)
let t = 12.0; // [8.0, 18.0] Bar thickness (mm)
let slot_w = 8.0; // [6.5, 10.0] Slot width (mm)
let drop = 8.0; // [4.0, 15.0] Toe and heel height (mm)
let w = width / 2.0;
let bar = box_from_corners([0, -w, 0], [length, w, t]);
let toe = box_from_corners([0, -w, -drop], [14.0, w, 0.5]);
let tt = toe.fillet(3.0, toe.edges("|Y and <X and <Z"));
let heel = box_from_corners([length - 14.0, -w, -drop], [length, w, 0.5]);
let slot = box_from_corners([length * 0.25, -slot_w / 2.0, -1], [length * 0.83, slot_w / 2.0, t + 1.0]) + cylinder([length * 0.25, 0, -1], "Z", slot_w / 2.0, t + 2.0) + cylinder([length * 0.83, 0, -1], "Z", slot_w / 2.0, t + 2.0);
bar + tt + heel - slot
