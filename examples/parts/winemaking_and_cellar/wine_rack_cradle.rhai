// Wine rack bottle cradle: 100 mm wide saddle for a 76 mm Bordeaux bottle, 40 mm deep solid block with the saddle sunk to 15% of the bottle radius from the floor and two 4 mm screw holes through the base
let bottle = 76.0; // [70.0, 92.0] Bottle diameter (mm)
let width = 100.0; // [80.0, 130.0] Cradle width (mm)
const depth = 40.0;
let r = bottle / 2.0;
let block = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, r * 0.8]);
let saddle = cylinder([0, -1.0, r * 0.8 + r * 0.35], "Y", r, depth + 2.0);
let c = block - saddle;
c - cylinder([-width / 2.0 + 12.0, depth / 2.0, -1.0], "Z", 2.0, 20.0) - cylinder([width / 2.0 - 12.0, depth / 2.0, -1.0], "Z", 2.0, 20.0)
