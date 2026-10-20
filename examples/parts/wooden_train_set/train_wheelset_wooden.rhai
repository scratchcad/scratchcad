// Wooden train wheel: 22 mm wheel 7 mm wide with 2 mm flange lip, 4 mm axle bore, 1 mm hub boss
let d = 22.0; // [16.0, 30.0] Wheel diameter (mm)
let w = 7.0; // [5.0, 10.0] Wheel width (mm)
let axle = 4.0; // [3.0, 6.0] Axle bore (mm)
let wheel = cylinder(d / 2.0, w) + cylinder([0, 0, -1.5], "Z", d / 2.0 + 1.5, 1.51) + cylinder([0, 0, w - 0.01], "Z", 4.0, 1.0);
wheel - cylinder([0, 0, -2], "Z", axle / 2.0, w + 4.0)
