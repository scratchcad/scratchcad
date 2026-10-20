// Saw bench hook: 250 x 200 x 12 mm bed, 30 mm top fence stopping 30 mm short for the saw kerf, 30 mm cleat underneath to hook the bench edge
let length = 250.0; // [150.0, 400.0] Bed length (mm)
let depth = 200.0; // [120.0, 300.0] Bed depth (mm)
let t = 12.0; // [9.0, 25.0] Bed thickness (mm)
let fence_h = 28.0; // [15.0, 45.0] Fence height (mm)
let kerf_gap = 30.0; // [15.0, 60.0] Gap left past the fence (mm)
let bed = box_from_corners([0, 0, 0], [length, depth, t]);
let fence = box_from_corners([0, depth - 30.0, t - 0.5], [length - kerf_gap, depth, t + fence_h]);
let cleat = box_from_corners([0, 0, -fence_h], [length, 30.0, 0.5]);
let p = bed + fence + cleat;
let screws = [];
for x in [length * 0.2, length * 0.5] {
    screws.push(cylinder([x, depth - 15.0, -1], "Z", 2.0, t + fence_h + 2.0));
    screws.push(cylinder([x, 15.0, -fence_h - 1.0], "Z", 2.0, fence_h + t + 2.0));
}
p.chamfer(1.0, p.edges("|Y and >Z")) - compound(screws)
