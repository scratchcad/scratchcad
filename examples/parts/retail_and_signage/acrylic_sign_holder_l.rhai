// L-shaped table sign holder base for A6: 110 x 40 mm foot 3 mm with a 3.2 mm slot block 10 mm tall
let width = 110.0; // [80.0, 220.0] Width (mm)
let depth = 40.0; // [25.0, 80.0] Foot depth (mm)
let slot = 3.2; // [1.5, 6.0] Slot width (mm)
let block_h = 10.0; // [6.0, 20.0] Block height (mm)
let foot = box_from_corners([0, 0, 0], [width, depth, 3.0]);
let f = foot.fillet(4.0, foot.edges("|Z"));
let block = box_from_corners([0, depth / 2.0 - slot / 2.0 - 4.0, 2.99], [width, depth / 2.0 + slot / 2.0 + 4.0, 3.0 + block_h]);
let b = block.chamfer(2.0, block.edges("|X and >Z"));
f + b - box_from_corners([-1, depth / 2.0 - slot / 2.0, 4.0], [width + 1.0, depth / 2.0 + slot / 2.0, 20.0])
