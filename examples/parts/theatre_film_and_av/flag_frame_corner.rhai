// Film flag frame corner: L-shaped corner block joining two 8 mm frame rods at 90 degrees, 25 x 25 mm legs 12 mm square, 8.2 mm rod bores 18 mm deep, 1.5 mm cloth slot on the outer edges
let leg = 25.0; // [18.0, 40.0] Leg length (mm)
let block = 12.0; // [10.0, 16.0] Block section (mm)
let rod = 8.2; // [6.0, 10.0] Rod bore (mm)
let bore_depth = 18.0; // [10.0, 25.0] Bore depth (mm)
let body = box_from_corners([0, 0, 0], [leg, block, block]) + box_from_corners([0, 0, 0], [block, leg, block]);
let b = body.fillet(1.0, body.edges("|Z"));
let bores = cylinder([leg + 1.0, block / 2.0, block / 2.0], "-X", rod / 2.0, bore_depth + 1.0) + cylinder([block / 2.0, leg + 1.0, block / 2.0], "-Y", rod / 2.0, bore_depth + 1.0);
let slots = box_from_corners([-1.0, -1.0, block / 2.0 - 0.75], [leg + 1.0, 2.5, block / 2.0 + 0.75]) + box_from_corners([-1.0, -1.0, block / 2.0 - 0.75], [2.5, leg + 1.0, block / 2.0 + 0.75]);
b - bores - slots
