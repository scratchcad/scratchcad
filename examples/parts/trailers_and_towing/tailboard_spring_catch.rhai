// Tailboard drop-down catch keeper: 60 x 30 x 4 mm plate with two 6.5 mm bolt holes, a 12 mm tall keeper hook block 20 mm wide with a 10 mm pin slot 8 mm deep
let pin = 10.0; // [6.0, 14.0] Catch pin diameter (mm)
let plate_l = 60.0; // [45.0, 80.0] Plate length (mm)
const t = 4.0;
let plate = box_centered(plate_l, 30.0, t).translate([0, 0, t / 2.0]);
let block = box_centered(20.0, 30.0, pin + 6.0).translate([0, 0, t + (pin + 6.0) / 2.0 - 0.01]);
let slot = box_from_corners([-pin / 2.0 - 0.3, -16.0, t + pin + 6.0 - 8.0 - pin / 2.0], [pin / 2.0 + 0.3, 16.0, t + pin + 7.0]) + cylinder([0, -16.0, t + pin + 6.0 - 8.0 - pin / 2.0], "Y", pin / 2.0 + 0.3, 32.0);
plate + block - slot - cylinder([-plate_l / 2.0 + 8.0, 0, -1.0], "Z", 3.25, t + 2.0) - cylinder([plate_l / 2.0 - 8.0, 0, -1.0], "Z", 3.25, t + 2.0)
