// Soil auger T-handle: 300 mm cross handle 32 mm dia with a 50 mm hub bored 25.4 mm for a 1 inch shaft, 8 mm cross-pin hole and 2 mm end chamfers
let span = 300.0; // [200.0, 450.0] Handle span (mm)
let grip = 32.0; // [25.0, 40.0] Grip diameter (mm)
let shaft = 25.4; // [19.0, 32.0] Shaft diameter (mm)
let bar = cylinder([-span / 2.0, 0, 0], "X", grip / 2.0, span);
let bar = bar.chamfer(2.0, bar.edges("%CIRCLE"));
let hub = cylinder([0, 0, -60.0], "Z", shaft / 2.0 + 8.0, 60.0);
bar + hub - cylinder([0, 0, -61.0], "Z", shaft / 2.0 + 0.2, 61.0) - cylinder([0, -40.0, -35.0], "Y", 4.0, 80.0)
