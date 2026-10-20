// Miniature circuit breaker lockout: clamp-on block 18 mm wide (one 17.5 mm module) 14 x 24 mm, 6 x 9 mm toggle pocket, 7.5 mm padlock shackle hole through the tab
let module_width = 18.0; // [17.0, 36.0] Lockout width (mm)
let depth = 14.0; // [10.0, 20.0] Depth (mm)
let height = 24.0; // [18.0, 32.0] Height (mm)
let shackle = 7.5; // [5.0, 9.0] Padlock shackle hole (mm)
let body = box_from_corners([-module_width / 2.0, 0, 0], [module_width / 2.0, depth, height]);
let b = body.fillet(2.0, body.edges("|Y"));
let pocket = box_from_corners([-3.0, -1.0, 4.0], [3.0, depth - 3.0, 13.0]);
let tab = box_from_corners([-4.0, depth - 4.0, height - 0.01], [4.0, depth, height + shackle + 5.0]);
let t = tab.fillet(3.9, tab.edges("|Y and >Z"));
// clamping screw boss
let screw = cylinder([0, depth / 2.0, -1.0], "Z", 1.6, 6.0);
(b + t) - pocket - cylinder([0, depth - 5.0, height + shackle / 2.0 + 1.0], "Y", shackle / 2.0, 6.0) - screw
