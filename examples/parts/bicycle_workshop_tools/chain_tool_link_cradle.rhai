// Chain tool link cradle: 24 x 18 x 14 mm block with a 7.8 mm wide channel 8 mm deep along its length that holds the chain on edge, 4 mm pin exit hole through the back wall at mid-channel depth, M3 tapped hole (2.5 mm) 5 mm deep from below under the channel near one end, 0.5 mm chamfered top edges
let length = 24.0; // [18.0, 34.0] Cradle length (mm)
let depth = 18.0; // [14.0, 24.0] Cradle depth (mm)
let height = 14.0; // [10.0, 20.0] Cradle height (mm)
let chain_w = 7.8; // [5.5, 8.5] Chain width (mm)
let channel = min(8.0, height - 4.0);
let block = box_centered(length, depth, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(0.5, block.edges(">Z"));
let cuts = fuse_all([
    box_from_corners([-length, -chain_w / 2.0, height - channel], [length, chain_w / 2.0, height + 1.0]),
    cylinder([0, 0, height - channel / 2.0], "Y", 2.0, depth),
    cylinder([length / 2.0 - 4.0, 0, -1.0], "Z", 1.25, min(6.0, height - channel - 1.0) + 1.0),
]);
block - cuts
