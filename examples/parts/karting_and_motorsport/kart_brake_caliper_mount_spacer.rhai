// Kart rear brake caliper mount spacer: 70 x 22 x 12 mm aluminium block with 3 mm rounded ends, two M8 clearance holes (8.5 mm) 50 mm apart, each counterbored 14 mm by 3 mm on one face, and a 10 x 2 mm relief groove across the middle of the underside
let spacing = 50.0; // [40.0, 70.0] Caliper bolt spacing (mm)
let thickness = 12.0; // [5.0, 25.0] Spacer thickness (mm)
let width = 22.0; // [18.0, 30.0] Spacer width (mm)
let length = spacing + 20.0;
let block = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let block = block.fillet(3.0, block.edges("|Z"));
let cuts = [box_centered(10.0, width + 2.0, 4.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * spacing / 2.0, 0, -1.0], "Z", 4.25, thickness + 2.0));
    cuts.push(cylinder([s * spacing / 2.0, 0, thickness - 3.0], "Z", 7.0, 4.0));
}
block - fuse_all(cuts)
