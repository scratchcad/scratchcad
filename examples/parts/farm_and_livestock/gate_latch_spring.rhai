// Farm gate spring latch keeper: 100 x 40 mm plate 4 mm, 45 mm deep U-catch for a 40 mm rail, 4 x 8 mm holes
let plate_h = 100.0; // [60.0, 150.0] Plate height (mm)
let width = 40.0; // [25.0, 60.0] Width (mm)
let catch_ = 45.0; // [30.0, 60.0] Catch depth (mm)
let rail = 40.0; // [25.0, 60.0] Rail size (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let plate = box_from_corners([0, 0, 0], [width, t, plate_h]);
let u = box_from_corners([0, t - 0.01, plate_h / 2.0 - rail / 2.0 - t], [width, catch_ + rail / 2.0, plate_h / 2.0 + rail / 2.0 + t]) - box_from_corners([-1, t, plate_h / 2.0 - rail / 2.0], [width + 1.0, catch_ + rail, plate_h / 2.0 + rail / 2.0]);
let holes = [];
for z in [10.0, plate_h - 10.0] { for x in [10.0, width - 10.0] { holes.push(cylinder([x, -1, z], "Y", 4.0, t + 2.0)); } }
plate + u - compound(holes)
