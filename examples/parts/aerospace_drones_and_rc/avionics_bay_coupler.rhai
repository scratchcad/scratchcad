// Avionics bay coupler for BT-60: 40.4 mm OD tube 120 mm long with 1.6 mm wall, 41.6 mm switch band 20 mm wide with a 4 mm switch hole
let od = 40.4; // [24.0, 100.0] Coupler outer diameter (mm)
let len = 120.0; // [60.0, 250.0] Length (mm)
let r = od / 2.0;
let bay = cylinder(r, len) + cylinder([0, 0, len / 2.0 - 10.0], "Z", r + 0.6, 20.0);
bay - cylinder([0, 0, -1], "Z", r - 1.6, len + 2.0) - cylinder([0, 0, len / 2.0], "X", 2.0, r + 2.0)
