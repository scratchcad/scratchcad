// Outboard clamp bracket zinc anode block: 100 x 30 x 15 mm block with 2 mm chamfered top edges and 4 mm rounded ends, two M6 countersunk holes (6.5 mm, 13 mm heads) 70 mm apart, and a 1.5 mm recess 60 x 20 mm in the back to seat against the bracket casting
let length = 100.0; // [60.0, 150.0] Anode length (mm)
let width = 30.0; // [20.0, 45.0] Anode width (mm)
let thickness = 15.0; // [8.0, 25.0] Anode thickness (mm)
let hole_spacing = 70.0; // [40.0, 120.0] Bolt hole spacing (mm)
let block = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
let block = block.fillet(4.0, block.edges("|Z"));
let block = block.chamfer(2.0, block.edges(">Z"));
let sp = min(hole_spacing, length - 20.0);
let cuts = [box_centered(min(60.0, sp - 16.0), width - 10.0, 3.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * sp / 2.0, 0, -1.0], "Z", 3.25, thickness + 2.0));
    cuts.push(cone(3.25, 6.5, 3.25).translate([s * sp / 2.0, 0, thickness - 3.24]));
}
block - fuse_all(cuts)
