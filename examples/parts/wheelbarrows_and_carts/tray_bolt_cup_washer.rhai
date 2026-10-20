// Wheelbarrow tray cup washer: 30 mm domed-style cup washer 2 mm thick with a 3 mm cup depth and an 8.5 mm hole for an M8 carriage bolt square neck (8.2 mm square)
let od = 30.0; // [20.0, 40.0] Washer OD (mm)
let square = 8.2; // [6.2, 10.2] Square neck size (mm)
const t = 2.0;
let w = cone(od / 2.0, od / 2.0 - 3.0, 3.0 + t) - cone(od / 2.0 - t, od / 2.0 - 3.0 - t, 3.0 + t).translate([0, 0, -t]);
w - box_centered(square, square, 20.0)
