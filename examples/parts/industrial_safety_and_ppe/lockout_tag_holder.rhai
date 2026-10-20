// Padlock tag holder: 80 x 145 mm lockout tag frame 3 mm thick with a 70 x 110 mm label recess 1 mm deep and a 20 x 8 mm shackle slot
let width = 80.0; // [60.0, 100.0] Tag width (mm)
let height = 145.0; // [100.0, 180.0] Tag height (mm)
let thickness = 3.0; // [2.0, 5.0] Thickness (mm)
let recess = 1.0; // [0.5, 1.5] Label recess depth (mm)
let tag = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, height, thickness]);
let t = tag.fillet(8.0, tag.edges("|Z"));
let label = box_from_corners([-width / 2.0 + 5.0, 8.0, thickness - recess], [width / 2.0 - 5.0, height - 27.0, thickness + 1.0]);
let lbl = label.fillet(3.0, label.edges("|Z"));
let slot = box_from_corners([-10.0, height - 18.0, -1], [10.0, height - 10.0, thickness + 1.0]);
let sl = slot.fillet(3.5, slot.edges("|Z"));
t - lbl - sl
