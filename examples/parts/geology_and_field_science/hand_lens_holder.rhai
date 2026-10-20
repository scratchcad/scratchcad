// 10x hand lens cell: 21 mm lens seated 6 mm deep in a 26 mm ring with a 1 mm retaining lip, a pivot ear with a 3.2 mm hole for the fold-away cover, and a 5 mm lanyard eye
let lens = 21.0; // [15.0, 30.0] Lens diameter (mm)
let cell = 6.0; // [4.0, 9.0] Cell depth (mm)
const wall = 2.5;
let ring_r = lens / 2.0 + wall;
let ring = cylinder([0, 0, 0], "Z", ring_r, cell) - cylinder([0, 0, 1.0], "Z", lens / 2.0, cell) - cylinder([0, 0, -1.0], "Z", lens / 2.0 - 1.0, 3.0);
let ear = box_from_corners([-4.0, ring_r - 1.0, 0], [4.0, ring_r + 6.0, cell]) - cylinder([0, ring_r + 3.0, -1.0], "Z", 1.6, cell + 2.0);
let eye = cylinder([0, -ring_r - 3.0, 0], "Z", 4.5, 3.0) - cylinder([0, -ring_r - 3.0, -1.0], "Z", 2.5, 5.0) + box_from_corners([-2.0, -ring_r - 1.0, 0], [2.0, -ring_r + 1.0, 3.0]);
ring + ear + eye
