// Pneumatic solenoid coil bobbin: 30 mm flanges 2 mm, 26 mm long, 9.2 mm armature tube bore, 14 mm winding core
let flange = 30.0; // [20.0, 45.0] Flange size (mm)
let length = 26.0; // [16.0, 40.0] Length (mm)
let core = 14.0; // [10.0, 22.0] Core diameter (mm)
let bore = 9.2; // [6.0, 14.0] Bore (mm)
let f = box_centered(flange, flange, 2.0);
let b = f.translate([0, 0, 1.0]) + cylinder([0, 0, 1.99], "Z", core / 2.0, length - 3.98) + f.translate([0, 0, length - 1.0]);
let pins = cylinder([flange / 2.0 - 3.0, 4.0, length - 0.01], "Z", 0.5, 5.0) + cylinder([flange / 2.0 - 3.0, -4.0, length - 0.01], "Z", 0.5, 5.0);
b + pins - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0)
