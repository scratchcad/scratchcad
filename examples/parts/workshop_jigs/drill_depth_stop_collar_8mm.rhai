// Drill depth stop collar for an 8 mm bit: 18 mm OD x 12 mm, 8.05 mm bore, M5 grub screw hole, 0.8 mm chamfers
let bit_d = 8.0; // [3.0, 13.0] Drill bit diameter (mm)
let od = 18.0; // [10.0, 30.0] Collar outside diameter (mm)
let length = 12.0; // [8.0, 20.0] Collar length (mm)
let screw_d = 4.2; // [2.5, 5.0] Grub screw tap hole (mm)
let ro = max(od / 2.0, bit_d / 2.0 + 4.0);
let c = cylinder(ro, length) - cylinder([0, 0, -1], "Z", bit_d / 2.0 + 0.025, length + 2.0);
let cc = c.chamfer(0.8, c.edges("%CIRCLE").filter(|e| e.radius() > ro - 0.01));
cc - cylinder([0, 0, length / 2.0], "X", screw_d / 2.0, ro + 1.0)
