// 30 ml porcelain crucible: 44 mm top tapering to 30 mm at the base, 40 mm tall, 2 mm wall; lid with a knob beside it
let top = 44.0; // [20.0, 80.0] Top diameter (mm)
let h = 40.0; // [20.0, 80.0] Height (mm)
let rb = top * 0.34;
let crucible = cone(rb, top / 2.0, h) - cone(rb - 2.0, top / 2.0 - 2.0 + 2.0 * (top / 2.0 - rb) / h, h).translate([0, 0, 2.0]);
let lid = cylinder(top / 2.0 + 1.0, 2.5) + cylinder([0, 0, -3.0], "Z", top / 2.0 - 2.2, 3.1) + sphere([0, 0, 5.0], 4.0);
compound([crucible, lid.translate([top + 15.0, 0, 3.0])])
