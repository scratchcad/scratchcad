// M8 J-bolt anchor: 8 mm rod, 100 mm straight leg, hook of 25 mm inside radius turned 180 degrees
let rod_d = 8.0; // [6.0, 20.0] Rod diameter (mm)
let leg = 100.0; // [40.0, 300.0] Straight leg length (mm)
let hook_r = 25.0; // [10.0, 60.0] Hook bend radius (mm)
let tail = 20.0; // [5.0, 60.0] Return length (mm)
let path = wire([line([0, 0, leg], [0, 0, 0]), arc([0, 0, 0], [hook_r, 0, -hook_r], [2.0 * hook_r, 0, 0]), line([2.0 * hook_r, 0, 0], [2.0 * hook_r, 0, tail])]);
circle([0, 0, leg], "Z", rod_d / 2.0).to_face().sweep(path)
