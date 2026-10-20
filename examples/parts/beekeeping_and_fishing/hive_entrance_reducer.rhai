// Langstroth hive entrance reducer: 368 x 19 x 19 mm cleat with a 10 mm and a 75 mm notch on adjacent faces
let length = 368.0; // [300.0, 420.0] Length (mm)
let size = 19.0; // [15.0, 25.0] Section (mm)
let small = 10.0; // [6.0, 20.0] Small entrance width (mm)
let large = 75.0; // [40.0, 120.0] Large entrance width (mm)
let cleat = box_from_corners([0, 0, 0], [length, size, size]);
cleat - box_from_corners([length / 2.0 - small / 2.0, -1, -1], [length / 2.0 + small / 2.0, size + 1.0, 9.5]) - box_from_corners([length / 2.0 - large / 2.0, -1, -1], [length / 2.0 + large / 2.0, 9.5, size + 1.0])
