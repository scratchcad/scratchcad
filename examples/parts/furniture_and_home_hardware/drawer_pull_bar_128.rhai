// Bar drawer pull, 128 mm hole centres: 12 mm bar 160 mm long with rounded ends, 10 mm legs 30 mm tall tapped M4
let cc = 128.0; // [64.0, 320.0] Hole centres (mm)
let rise = 30.0; // [20.0, 45.0] Projection (mm)
let len = cc + 32.0;
let bar = cylinder([-len / 2.0, 0, rise], "X", 6.0, len).fillet(2.0, "%CIRCLE");
let pull = bar;
for x in [-cc / 2.0, cc / 2.0] { pull += cylinder([x, 0, 0], "Z", 5.0, rise); }
for x in [-cc / 2.0, cc / 2.0] { pull -= cylinder([x, 0, -1], "Z", 1.65, 11.0); }
pull
