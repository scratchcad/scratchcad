// Kart steering column support block in UHMW, two halves: 50 x 40 x 40 mm block with a 20.2 mm column bore 22 mm above the base, split horizontally through the bore with a 1 mm gap into a base and a cap, two M8 clearance holes (8.5 mm) through for the chassis bracket and 2 mm chamfered vertical edges
let column_d = 20.0; // [16.0, 25.0] Steering column diameter (mm)
let width = 50.0; // [45.0, 70.0] Block width (mm)
let length = 40.0; // [25.0, 60.0] Block length along the column (mm)
const height = 40.0;
let zc = column_d / 2.0 + 12.0;
let h = max(height, zc + column_d / 2.0 + 8.0);
let block = box_centered(width, length, h).translate([0, 0, h / 2.0]);
let block = block.chamfer(2.0, block.edges("|Z"));
let xb = column_d / 2.0 + 6.0 + (width / 2.0 - column_d / 2.0 - 6.0) / 2.0;
let cuts = [
    cylinder([0, -length / 2.0 - 1.0, zc], "Y", column_d / 2.0 + 0.1, length + 2.0),
    box_centered(width + 2.0, length + 2.0, 1.0).translate([0, 0, zc])
];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * xb, 0, -1.0], "Z", 4.25, h + 2.0));
}
block - fuse_all(cuts)
