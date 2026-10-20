// Tablet counting spatula: 150 mm overall, 70 mm flat blade 26 mm wide and 1.6 mm thick with a square counting edge and 4 mm rounded corners, tapering over 15 mm into an 80 mm handle 14 x 8 mm with 3 mm rounded edges and a 5 mm hanging hole
let blade_len = 70.0; // [50.0, 90.0] Blade length (mm)
let blade_w = 26.0; // [18.0, 34.0] Blade width (mm)
let blade_t = 1.6; // [1.0, 2.5] Blade thickness (mm)
let handle_len = 80.0; // [60.0, 110.0] Handle length (mm)
const handle_w = 14.0;
const handle_t = 8.0;
const neck = 15.0;
let blade = box_from_corners([0, -blade_w / 2.0, 0], [blade_len, blade_w / 2.0, blade_t]);
let blade = blade.fillet(4.0, blade.edges("|Z and <X"));
let neck_shape = polygon([
    [blade_len - 1.0, -blade_w / 2.0, 0], [blade_len + neck, -handle_w / 2.0, 0],
    [blade_len + neck, handle_w / 2.0, 0], [blade_len - 1.0, blade_w / 2.0, 0],
]).to_face().extrude([0, 0, blade_t]);
let hx0 = blade_len + neck - 0.5;
let handle = box_from_corners([hx0, -handle_w / 2.0, 0], [hx0 + handle_len, handle_w / 2.0, handle_t]);
let handle = handle.fillet(3.0, handle.edges("|X or (|Z and >X) or (|Y and >X)"));
let tool = fuse_all([blade, neck_shape, handle]);
tool - cylinder([hx0 + handle_len - 9.0, 0, -1.0], "Z", 2.5, handle_t + 2.0)
