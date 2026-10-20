// Snap-on DIN rail (TS35) mounting clip: 45 mm tall, 10 mm wide, fixed hook on top and flexible latch at the bottom
let width = 10.0; // [6.0, 30.0] Width (mm)
let plate_t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let height = 45.0; // [40.0, 70.0] Height (mm)
let plate = box(width, plate_t, height).translate([0, 0, -height / 2.0]);
let hook = box_from_corners([0, plate_t - 0.01, 17.5 - 1.2], [width, plate_t + 2.3, 17.5 + 3.0]) + box_from_corners([0, plate_t + 1.2, 17.5 - 1.2], [width, plate_t + 2.3, 17.5 + 0.2]);
let hook_lip = box_from_corners([0, plate_t + 1.0, 17.5 - 2.6], [width, plate_t + 2.3, 17.5 - 1.2]);
let latch = box_from_corners([0, plate_t - 0.01, -17.5 - 3.0], [width, plate_t + 2.3, -17.5 + 1.0]) - box_from_corners([-1, plate_t + 1.0, -17.5 - 1.0], [width + 1, plate_t + 3.0, -17.5 + 2.0]);
let spring_slot = box_from_corners([-1, -1, -height / 2.0 + 4.0], [width + 1, plate_t - 1.2, -17.5 + 4.0]);
(fuse_all([plate, hook, hook_lip, latch]) - spring_slot) - cylinder([width / 2.0, -1, 0], "Y", 2.2, plate_t + 2.0)
