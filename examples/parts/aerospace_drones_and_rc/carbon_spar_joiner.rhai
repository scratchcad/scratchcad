// Carbon tube spar joiner: 8 mm OD, 6.8 mm ID, 60 mm long, 10 mm centre stop ring 2 mm wide
let od = 8.0; // [4.0, 16.0] Outer diameter (mm)
let len = 60.0; // [30.0, 120.0] Length (mm)
let tube = cylinder(od / 2.0, len) + cylinder([0, 0, len / 2.0 - 1.0], "Z", od / 2.0 + 1.0, 2.0);
tube - cylinder([0, 0, -1], "Z", od / 2.0 - 0.6, len + 2.0)
