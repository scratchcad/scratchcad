// Oven control knob: 40 mm knob 22 mm tall, raised 8 mm grip bar, 6 mm D-shaft socket 15 mm deep, pointer
let diameter = 40.0; // [30.0, 55.0] Knob diameter (mm)
let height = 22.0; // [15.0, 30.0] Height (mm)
let shaft = 6.0; // [4.0, 8.0] Shaft diameter (mm)
let skirt = cylinder(diameter / 2.0, 6.0) - cylinder([0, 0, -1], "Z", diameter / 2.0 - 2.0, 5.0);
let bar = box_centered(diameter - 4.0, 9.0, height - 5.99).translate([0, 0, 6.0 + (height - 6.0) / 2.0 - 0.01]);
let b = bar.fillet(4.0, bar.edges("|Y and >Z"));
let boss = cylinder([0, 0, 0], "Z", shaft / 2.0 + 3.0, 16.0);
let d = cylinder([0, 0, -1], "Z", shaft / 2.0, 16.0) - box_from_corners([shaft / 2.0 - 1.5, -shaft, -2], [shaft, shaft, 17.0]);
let pointer = box_from_corners([diameter / 2.0 - 8.0, -0.6, height - 0.6], [diameter / 2.0 - 2.0, 0.6, height + 1.0]);
skirt + b + boss - d - pointer
