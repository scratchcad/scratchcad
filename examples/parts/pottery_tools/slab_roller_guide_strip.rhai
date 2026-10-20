// Clay slab rolling guide: 300 x 25 mm strip, stepped 3, 6 and 10 mm thick sections 100 mm each
let length = 300.0; // [200.0, 450.0] Strip length (mm)
let width = 25.0; // [15.0, 40.0] Width (mm)
let a = box_from_corners([0, 0, 0], [length / 3.0, width, 3.0]);
let b = box_from_corners([length / 3.0 - 0.01, 0, 0], [2.0 * length / 3.0, width, 6.0]);
let c = box_from_corners([2.0 * length / 3.0 - 0.01, 0, 0], [length, width, 10.0]);
a + b + c
