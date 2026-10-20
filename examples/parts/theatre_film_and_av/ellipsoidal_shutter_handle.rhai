// Ellipsoidal (profile spot) framing shutter handle: 50 mm paddle 14 mm wide 3 mm thick on a 30 mm neck, 6 x 1.2 mm slot fitting the shutter blade tang with a 3 mm rivet hole, finger dimple
let paddle = 50.0; // [30.0, 70.0] Paddle length (mm)
let width = 14.0; // [12.0, 20.0] Paddle width (mm)
let thickness = 3.0; // [2.0, 5.0] Thickness (mm)
let neck = 30.0; // [15.0, 45.0] Neck length (mm)
const neck_w = 8.0;
let body = box_from_corners([0, -neck_w / 2.0, 0], [neck, neck_w / 2.0, thickness]) + box_from_corners([neck - 0.01, -width / 2.0, 0], [neck + paddle, width / 2.0, thickness]);
// the step between neck and paddle carries two fillets, so keep them under half of it
let fr = ((width - neck_w) / 4.0 - 0.1).min(1.2);
let b = body.fillet(fr, body.edges("|Z"));
let tang = box_from_corners([-1.0, -3.0, (thickness - 1.2) / 2.0], [12.0, 3.0, (thickness + 1.2) / 2.0]);
let rivet = cylinder([6.0, 0, -1.0], "Z", 1.5, thickness + 2.0);
let dimple = sphere([neck + paddle * 0.6, 0, thickness + 6.0], 7.0);
b - tang - rivet - dimple
