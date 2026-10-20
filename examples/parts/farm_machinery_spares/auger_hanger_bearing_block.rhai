// Grain auger flight hanger bearing block for a 1-1/4 inch (31.75 mm) shaft: nylon block 70 x 45 x 50 mm with a 32.2 mm bore 45 mm long along the shaft, 1.5 mm bore chamfers, two 10.5 mm hanger bolt holes 52 mm apart running top to bottom, a 6 mm grease hole from the top into the bore, and 3 mm chamfered vertical corners
let shaft_d = 32.2; // [20.0, 42.0] Bore diameter (mm)
let block_w = 70.0; // [55.0, 95.0] Block width (mm)
let block_len = 45.0; // [30.0, 60.0] Block length along the shaft (mm)
let block_h = 50.0; // [40.0, 70.0] Block height (mm)
let bolt_pitch = 52.0; // [44.0, 76.0] Bolt spacing (mm)
const bolt_d = 10.5;
let rb = shaft_d / 2.0;
let bp = max(min(bolt_pitch, block_w - 16.0), shaft_d + bolt_d + 6.0);
let w = max(block_w, bp + 16.0);
let block = box_from_corners([0, -w / 2.0, 0], [block_len, w / 2.0, block_h]);
let block = block.chamfer(3.0, block.edges("|Z"));
let zc = block_h / 2.0;
let block = block - fuse_all([
    cylinder([-1.0, 0, zc], "X", rb, block_len + 2.0),
    cylinder([block_len / 2.0, -bp / 2.0, -1.0], "Z", bolt_d / 2.0, block_h + 2.0),
    cylinder([block_len / 2.0, bp / 2.0, -1.0], "Z", bolt_d / 2.0, block_h + 2.0),
    cylinder([block_len / 2.0, 0, zc], "Z", 3.0, block_h),
]);
block.chamfer(1.5, block.edges("%CIRCLE").filter(|e| e.radius() > 9.0))
