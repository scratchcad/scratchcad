// Wheel dishing gauge end foot: 40 x 16 x 24 mm block, 25.4 x 5.2 mm pocket for the flat gauge bar 14 mm deep, M5 thumb screw hole (4.2 mm) into the pocket, 90 degree V-notch 5 mm deep across the bottom to sit on the rim
let bar_w = 25.4; // [20.0, 32.0] Bar width (mm)
let bar_t = 5.2; // [3.2, 6.5] Bar thickness (mm)
let height = 24.0; // [20.0, 32.0] Foot height (mm)
let notch_depth = 5.0; // [3.0, 7.0] Notch depth (mm)
const depth = 16.0;
const pocket_depth = 14.0;
let length = bar_w + 14.6;
let foot = box_from_corners([-length / 2.0, -depth / 2.0, 0], [length / 2.0, depth / 2.0, height]);
let foot = foot.chamfer(1.0, foot.edges("|Y and >Z"));
let notch = polygon([[-notch_depth - 1.0, -depth, -1.0], [notch_depth + 1.0, -depth, -1.0], [0, -depth, notch_depth]]).to_face().extrude([0, 2.0 * depth, 0]);
let cuts = fuse_all([
    notch,
    box_from_corners([-bar_w / 2.0, -bar_t / 2.0, height - pocket_depth], [bar_w / 2.0, bar_t / 2.0, height + 1.0]),
    cylinder([-length / 2.0 - 1.0, 0, height - pocket_depth / 2.0], "X", 2.1, (length - bar_w) / 2.0 + 2.0),
]);
foot - cuts
