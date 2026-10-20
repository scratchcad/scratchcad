// Cymbal stand sleeve: fits an 8 mm (M8) tilter rod, 12.5 mm OD 30 mm long, 22 mm flange washer seat 2 mm
let rod = 8.0; // [6.0, 10.0] Rod diameter (mm)
let od = 12.5; // [10.0, 15.0] Sleeve OD (mm)
let length = 30.0; // [20.0, 40.0] Sleeve length (mm)
let s = cylinder(od / 2.0, length) + cylinder(11.0, 2.0);
s - cylinder([0, 0, -1], "Z", rod / 2.0 + 0.2, length + 2.0)
