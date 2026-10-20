// Battery strap buckle for a 20 mm strap: 26 x 16 x 2 mm frame with two 3 mm slots and a ridged centre bar
let strap = 20.0; // [10.0, 30.0] Strap width (mm)
let b = box_centered(strap + 6.0, 16.0, 2.0);
for y in [-3.5, 3.5] { b -= box_centered(strap + 0.5, 3.0, 4.0).translate([0, y, 0]); }
for x in [-6.0, -2.0, 2.0, 6.0] { b += box_centered(1.0, 4.0, 0.6).translate([x, 0, 1.2]); }
b
