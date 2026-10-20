// Eccentric sheave and strap: 60 mm sheave 12 mm wide with 8 mm throw (4 mm offset) on a 20 mm bore, flanged sides, and a split strap with 50 mm rod arm
let sheave_diameter = 60.0; // [30.0, 120.0] Sheave diameter (mm)
let offset = 4.0; // [1.0, 15.0] Eccentric offset (mm)
let width = 12.0; // [6.0, 30.0] Sheave width (mm)
let bore = 20.0; // [6.0, 40.0] Shaft bore (mm)
let arm_length = 50.0; // [20.0, 150.0] Strap arm length (mm)
let rs = sheave_diameter / 2.0;
let off = min(offset, rs - bore / 2.0 - 4.0);
let sheave = cylinder([off, 0, 0], "Z", rs, width) + cylinder([off, 0, -1.5], "Z", rs + 2.0, 1.51) + cylinder([off, 0, width - 0.01], "Z", rs + 2.0, 1.51);
sheave = sheave - cylinder([0, 0, -3], "Z", bore / 2.0, width + 6.0);
let strap = cylinder([off, 0, 0.1], "Z", rs + 6.0, width - 0.2) - cylinder([off, 0, -1], "Z", rs + 0.1, width + 2.0);
let arm = box_from_corners([off + rs + 5.0, -6.0, 0.1], [off + rs + arm_length, 6.0, width - 0.1]);
strap = strap + arm;
strap = strap - box_from_corners([off - 0.5, -rs - 10.0, -1], [off + 0.5, rs + 10.0, width + 1.0]);
strap = strap - cylinder([off + rs + arm_length - 6.0, 0, -1], "Z", 4.0, width + 2.0);
compound([sheave, strap])
