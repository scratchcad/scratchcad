// Metered-dose inhaler mouthpiece cap: rounded-rectangle cap 24 x 17 mm inside, 13 mm deep with a 1.2 mm wall and 1.5 mm end, 6 mm corner radius inside, and a 10 x 8 mm tether tab off one long side with a 4 mm hole
let inner_w = 24.0; // [20.0, 30.0] Inside width (mm)
let inner_h = 17.0; // [14.0, 22.0] Inside height (mm)
let depth = 13.0; // [9.0, 18.0] Cap depth (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
const end_t = 1.5;
const corner_r = 6.0;
let ow = inner_w + 2.0 * wall;
let oh = inner_h + 2.0 * wall;
let outer = box_centered(ow, oh, depth + end_t).translate([0, 0, (depth + end_t) / 2.0]);
let outer = outer.fillet(corner_r + wall, outer.edges("|Z"));
let inner = box_centered(inner_w, inner_h, depth + 1.0).translate([0, 0, end_t + (depth + 1.0) / 2.0]);
let inner = inner.fillet(corner_r, inner.edges("|Z"));
let tab = box_from_corners([-4.0, oh / 2.0 - 1.0, 0], [4.0, oh / 2.0 + 10.0, end_t]);
let tab = tab.fillet(3.5, tab.edges("|Z and >Y"));
let cap = (outer - inner) + tab;
cap - cylinder([0, oh / 2.0 + 5.5, -1.0], "Z", 2.0, end_t + 2.0)
