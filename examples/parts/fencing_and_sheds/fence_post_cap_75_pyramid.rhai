// Fence post cap for a 75 mm square post: 81 mm square skirt 20 mm deep, 3 mm walls, with a 25 mm high pyramid top and a 2 mm drip lip
let post = 75.0; // [70.0, 100.0] Post size (mm)
let skirt = 20.0; // [12.0, 30.0] Skirt depth (mm)
const wall = 3.0;
let s = post + 2.0 * wall;
let box_ = box_centered(s, s, skirt).translate([0, 0, skirt / 2.0]) - box_centered(post + 0.5, post + 0.5, skirt).translate([0, 0, skirt / 2.0 - wall]);
let lip = box_centered(s + 4.0, s + 4.0, 2.0).translate([0, 0, skirt - 1.0]);
let pyramid = loft([rect(plane([0, 0, skirt - 0.01], [0, 0, 1]), s + 4.0, s + 4.0), rect(plane([0, 0, skirt + 25.0], [0, 0, 1]), 4.0, 4.0)], true);
box_ + lip + pyramid
