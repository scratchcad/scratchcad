// Magnetic drawer lock catch: 40 x 20 x 15 mm housing, spring latch hook 25 mm, 2 screw holes
let length = 40.0; // [30.0, 60.0] Housing length (mm)
let width = 20.0; // [15.0, 30.0] Width (mm)
let height = 15.0; // [10.0, 20.0] Height (mm)
let housing = box_from_corners([0, 0, 0], [length, width, height]);
let h = housing.fillet(3.0, housing.edges("|Z"));
let pocket = box_from_corners([8.0, 4.0, 2.0], [length - 4.0, width - 4.0, height + 1.0]);
let hook = box_from_corners([10.0, width / 2.0 - 2.5, 1.99], [12.0, width / 2.0 + 2.5, height + 25.0]) + box_from_corners([10.0, width / 2.0 - 2.5, height + 20.0], [16.0, width / 2.0 + 2.5, height + 25.0]);
h - pocket + hook - cylinder([4.0, width / 2.0, -1], "Z", 1.8, height + 2.0) - cylinder([length - 2.0, width / 2.0, -1], "Z", 1.0, height + 2.0)
