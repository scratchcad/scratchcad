// Axle vise insert, one half of a pair: 60 x 25 x 20 mm aluminium block with 9.2, 10.2 and 12.2 mm semicircular axle grooves across the top 18 mm apart, 1 mm chamfered top edges
let length = 60.0; // [54.0, 80.0] Block length (mm)
let depth = 25.0; // [20.0, 35.0] Block depth (mm)
let height = 20.0; // [14.0, 30.0] Block height (mm)
let spacing = 18.0; // [16.0, 22.0] Groove spacing (mm)
let grooves = fuse_all([
    cylinder([-spacing, -depth, height], "Y", 4.6, 2.0 * depth),
    cylinder([0, -depth, height], "Y", 5.1, 2.0 * depth),
    cylinder([spacing, -depth, height], "Y", 6.1, 2.0 * depth),
]);
let block = box_from_corners([-length / 2.0, -depth / 2.0, 0], [length / 2.0, depth / 2.0, height]);
let block = block.chamfer(1.0, block.edges(">Z and |Y"));
block - grooves
