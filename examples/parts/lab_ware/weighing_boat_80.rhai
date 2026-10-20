// Square weighing boat: 80 mm top tapering to 60 mm at the 20 mm deep base, 1 mm wall
let top = 80.0; // [30.0, 140.0] Top size (mm)
let h = 20.0; // [8.0, 40.0] Depth (mm)
let b = top * 0.75;
let outer = loft([rect(plane([0, 0, 0], "Z"), b, b), rect(plane([0, 0, h], "Z"), top, top)], true);
let inner = loft([rect(plane([0, 0, 1.0], "Z"), b - 2.0, b - 2.0), rect(plane([0, 0, h + 1.0], "Z"), top - 2.0 + 2.0 * (top - b) / (2.0 * h), top - 2.0 + 2.0 * (top - b) / (2.0 * h))], true);
outer - inner
