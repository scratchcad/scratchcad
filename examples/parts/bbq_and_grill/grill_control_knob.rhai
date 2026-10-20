// Gas grill control knob: 50 mm skirt 25 mm tall, 30 mm grip fin, 6 mm D-shaft 7 mm deep, pointer notch
let diameter = 50.0; // [35.0, 65.0] Skirt diameter (mm)
let height = 25.0; // [18.0, 35.0] Height (mm)
let shaft = 6.0; // [5.0, 8.0] Valve stem (mm)
let skirt = cylinder(diameter / 2.0, 8.0) - cylinder([0, 0, -1], "Z", diameter / 2.0 - 2.5, 7.0);
let fin = box_centered(30.0, 10.0, height - 7.99).translate([0, 0, 8.0 + (height - 8.0) / 2.0 - 0.01]);
let f = fin.fillet(4.5, fin.edges("|Y and >Z"));
let boss = cylinder(shaft / 2.0 + 3.0, 10.0);
let d = cylinder([0, 0, -1], "Z", shaft / 2.0, 8.0) - box_from_corners([shaft / 2.0 - 1.0, -shaft, -2], [shaft, shaft, 9.0]);
skirt + f + boss - d - box_from_corners([diameter / 2.0 - 4.0, -0.7, 6.0], [diameter / 2.0 + 1.0, 0.7, 9.0])
