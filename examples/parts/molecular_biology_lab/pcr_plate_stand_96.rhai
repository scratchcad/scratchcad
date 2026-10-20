// PCR plate cold stand: 127.8 x 85.5 mm SBS footprint block 20 mm tall with 96 conical wells (5.5 mm top, 2 mm tip, 15 mm deep) on a 9 mm pitch, A1 corner chamfer
let depth = 15.0; // [10.0, 18.0] Well depth (mm)
let well = 5.5; // [5.0, 6.5] Well top diameter (mm)
const h = 20.0;
let b = box_from_corners([0, 0, 0], [127.8, 85.5, h]);
let b = b.chamfer(4.0, b.edges("|Z and <X and >Y"));
let wells = [];
for c in 0..12 { for r in 0..8 { wells.push(cone(1.0, well / 2.0, depth).translate([14.4 + 9.0 * c.to_float(), 11.2 + 9.0 * r.to_float(), h - depth + 0.01])); } }
b - fuse_all(wells)
