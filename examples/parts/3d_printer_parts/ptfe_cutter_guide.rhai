// PTFE tube cutting jig: 40 x 15 x 12 mm block, 4.1 mm tube channel, 0.6 mm blade slot square to the tube
let length = 40.0; // [25.0, 60.0] Length (mm)
let width = 15.0; // [10.0, 25.0] Width (mm)
let height = 12.0; // [8.0, 20.0] Height (mm)
let tube = 4.1; // [3.0, 6.5] Tube diameter (mm)
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(1.5, "|X");
block = block - cylinder([-length, 0, height / 2.0], "X", tube / 2.0, length * 2.0);
block - box_centered(0.6, width + 2.0, height).translate([length * 0.2, 0, height / 2.0 + 2.0])
