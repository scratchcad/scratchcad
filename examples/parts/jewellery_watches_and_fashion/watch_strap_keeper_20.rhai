// Watch strap keeper (loop) for a 20 mm strap: 20.5 x 4 mm opening, 1.2 mm walls, 5 mm long, with a small locating nub inside
let strap_width = 20.0; // [12.0, 26.0] Strap width (mm)
let strap_thickness = 4.0; // [2.0, 6.0] Strap thickness at the keeper (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let keeper_length = 5.0; // [3.0, 8.0] Keeper length along the strap (mm)
let iw = strap_width + 0.5;
let ih = strap_thickness;
let outer = box_centered(iw + 2.0 * wall, keeper_length, ih + 2.0 * wall).fillet(min(ih / 2.0 + wall - 0.1, 2.5), "|Y");
let inner = box_centered(iw, keeper_length + 2.0, ih).fillet(min(ih / 2.0 - 0.1, 1.0), "|Y");
let keeper = outer - inner;
// nub on the inside of the top wall keeps the keeper from sliding
let nub = cylinder([-iw / 4.0, -keeper_length / 2.0, ih / 2.0 + 0.1], "Y", 0.5, keeper_length);
keeper + nub
