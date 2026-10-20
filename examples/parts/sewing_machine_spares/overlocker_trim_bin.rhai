// Overlocker trim waste bin: 200 x 80 x 50 mm open box with 2 mm walls and 8 mm rounded vertical corners, a 4 mm hooked lip along the back that hangs on the machine bed, and a 60 x 25 mm finger scoop cut in the front wall
let length = 200.0; // [140.0, 260.0] Bin length (mm)
let depth = 80.0; // [60.0, 110.0] Bin depth (mm)
let height = 50.0; // [35.0, 70.0] Bin height (mm)
const wall = 2.0;
let outer = box_from_corners([0, 0, 0], [length, depth, height]);
let outer = outer.fillet(8.0, outer.edges("|Z"));
let inner = box_from_corners([wall, wall, wall], [length - wall, depth - wall, height + 1.0]);
let inner = inner.fillet(6.0, inner.edges("|Z"));
let bin = outer - inner;
let lip = box_from_corners([10.0, depth - 1.0, height - wall], [length - 10.0, depth + 8.0, height]) + box_from_corners([10.0, depth + 6.0, height - 10.0], [length - 10.0, depth + 8.0, height - 1.0]);
let scoop = box_from_corners([length / 2.0 - 30.0, -1.0, height - 25.0], [length / 2.0 + 30.0, wall + 1.0, height + 1.0]);
(bin + lip) - scoop
