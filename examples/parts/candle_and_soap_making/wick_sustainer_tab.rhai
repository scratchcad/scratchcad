// Wick sustainer tab: 15 mm disc 0.6 mm thick with a 6 mm tall neck 3 mm OD crimping a 1.5 mm wick
let dia = 15.0; // [10.0, 20.0] Tab diameter (mm)
let neck = 6.0; // [3.0, 10.0] Neck height (mm)
let t = cylinder([0, 0, 0], "Z", dia / 2.0, 0.6) + cylinder([0, 0, 0.59], "Z", 1.5, neck);
t - cylinder([0, 0, -1.0], "Z", 0.75, neck + 3.0)
