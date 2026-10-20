// 15 mm LWS rod clamp for camera rigs: 90 x 25 x 22 mm block, two 15 mm rod bores on 60 mm centres, each with a split and an M5 clamping screw hole, centre 1/4-20 and 3/8-16 tapped holes
let rod_spacing = 60.0; // [40.0, 100.0] Rod centre spacing (mm)
let rod_diameter = 15.0; // [12.0, 19.0] Rod diameter (mm)
let block_depth = 25.0; // [15.0, 40.0] Block depth along the rods (mm)
let block_height = 22.0; // [20.0, 30.0] Block height (mm)
let wall = 7.5; // [5.0, 12.0] Material outside each rod bore (mm)
let length = rod_spacing + rod_diameter + 2.0 * wall;
let zc = block_height / 2.0;
let block = box_centered(length, block_depth, block_height).translate([0, 0, zc]).fillet(3.0, "|Y").chamfer(0.5, "|X");
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * rod_spacing / 2.0;
    cuts.push(cylinder([x, -block_depth / 2.0 - 1.0, zc], "Y", rod_diameter / 2.0 + 0.05, block_depth + 2.0));
    // split from the bore out to the end of the block
    cuts.push(box_from_corners([x + s * (rod_diameter / 2.0 - 1.0), -block_depth, zc - 0.6], [s * (length / 2.0 + 1.0), block_depth, zc + 0.6]));
    // clamping screw across the split
    let xs = x + s * (rod_diameter / 2.0 + wall / 2.0);
    cuts.push(cylinder([xs, 0, -1.0], "Z", 2.6, block_height + 2.0) + cylinder([xs, 0, block_height - 3.0], "Z", 4.5, 4.0));
}
// centre mounting holes (tap drill sizes): 1/4-20 from the top, 3/8-16 from the bottom
cuts.push(cylinder([0, 0, block_height - 10.0], "Z", 2.55, 11.0));
cuts.push(cylinder([0, 0, -1.0], "Z", 4.2, 11.0));
let clamp = block;
for c in cuts { clamp -= c; }
clamp
