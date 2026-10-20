// Sippy cup spout lid: 70 mm lid snap 12 mm skirt, 25 x 12 mm spout 20 mm tall, 2 mm wall, 1.5 mm valve hole
let lid = 70.0; // [55.0, 85.0] Cup rim diameter (mm)
let skirt = 12.0; // [8.0, 18.0] Skirt depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let shell = cylinder(lid / 2.0 + wall, skirt + wall) - cylinder([0, 0, -1], "Z", lid / 2.0, skirt + 1.0);
let snap = cylinder([0, 0, 2.0], "Z", lid / 2.0 + 0.01, 1.2) - cylinder([0, 0, 1.0], "Z", lid / 2.0 - 1.0, 4.0);
let spout = loft([rect(plane([12.0, 0, skirt + wall - 0.01], [0, 0, 1]), 25.0, 18.0), rect(plane([15.0, 0, skirt + wall + 20.0], [0, 0, 1]), 22.0, 8.0)], true);
let sp = spout - loft([rect(plane([12.0, 0, skirt - 0.01], [0, 0, 1]), 25.0 - 2.0 * wall, 18.0 - 2.0 * wall), rect(plane([15.0, 0, skirt + wall + 20.0 - wall], [0, 0, 1]), 22.0 - 2.0 * wall, 8.0 - 2.0 * wall)], true);
shell + snap + sp - cylinder([15.0, 0, skirt + wall + 18.0], "Z", 0.75, 5.0) - cylinder([-20.0, 0, skirt - 1.0], "Z", 1.0, 5.0)
