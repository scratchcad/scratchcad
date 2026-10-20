// Sleeping pad flat valve: 25 mm weld flange 2 mm, 12 mm tall barrel 15 mm OD with 9 mm bore, cap groove
let flange_d = 25.0; // [18.0, 35.0] Weld flange diameter (mm)
let barrel_d = 15.0; // [10.0, 20.0] Barrel diameter (mm)
let height = 12.0; // [8.0, 18.0] Barrel height (mm)
let bore = 9.0; // [5.0, 13.0] Bore (mm)
let v = cylinder(flange_d / 2.0, 2.0) + cylinder([0, 0, 1.99], "Z", barrel_d / 2.0, height - 1.99);
let groove = cylinder([0, 0, height - 5.0], "Z", barrel_d / 2.0 + 1.0, 1.5) - cylinder([0, 0, height - 6.0], "Z", barrel_d / 2.0 - 0.8, 4.0);
v - groove - cylinder([0, 0, -1], "Z", bore / 2.0, height + 2.0)
