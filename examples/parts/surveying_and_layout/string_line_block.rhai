// Mason's line block: 75 x 20 x 20 mm block with a 2 mm line slot and 60 mm corner rebate 10 x 10 mm
let length = 75.0; // [50.0, 100.0] Block length (mm)
let size = 20.0; // [15.0, 30.0] Block section (mm)
let b = box_from_corners([0, 0, 0], [length, size, size]);
b - box_from_corners([-1, size / 2.0, size / 2.0], [length - 15.0, size + 1.0, size + 1.0]) - box_from_corners([length - 6.0, -1, size / 2.0 - 1.0], [length + 1.0, size + 1.0, size / 2.0 + 1.0])
