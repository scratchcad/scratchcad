// Cherry MX 1u keycap, DSA-like: 18 mm base, 12.7 mm top, 7.6 mm tall, dished top, cross stem 4.1 x 1.3 mm
let base = 18.0; // [17.0, 19.0] Base size (mm)
let top = 12.7; // [10.0, 15.0] Top size (mm)
let height = 7.6; // [6.0, 12.0] Height (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let shell = loft([rect(plane([0, 0, 0], [0, 0, 1]), base, base), rect(plane([0, 0, height], [0, 0, 1]), top, top)], true);
let inner = loft([rect(plane([0, 0, -0.01], [0, 0, 1]), base - 2.0 * wall, base - 2.0 * wall), rect(plane([0, 0, height - wall], [0, 0, 1]), top - 2.0 * wall, top - 2.0 * wall)], true);
let dish = sphere([0, 0, height + 40.0 - 0.8], 40.0);
let stem = cylinder([0, 0, 0.5], "Z", 2.75, height - wall - 0.49) - box_centered(4.1, 1.3, 10.0).translate([0, 0, 4.0]) - box_centered(1.3, 4.1, 10.0).translate([0, 0, 4.0]);
shell - inner - dish + stem
