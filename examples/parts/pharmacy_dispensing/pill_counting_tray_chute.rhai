// Pill counting tray with chute: 190 x 105 x 16 mm tray with 2 mm floor and walls and 6 mm corner radius, a 24 mm trough down the right side behind a divider 45% of the wall height, and a 14 mm pouring spout 10 mm long at the trough's front end
let length = 190.0; // [150.0, 230.0] Tray length (mm)
let width = 105.0; // [85.0, 130.0] Tray width (mm)
let height = 16.0; // [12.0, 22.0] Wall height (mm)
let trough_w = 24.0; // [18.0, 32.0] Trough width (mm)
let spout_w = 14.0; // [10.0, 18.0] Spout width (mm)
const wall = 2.0;
const floor_t = 2.0;
let sw = min(spout_w, trough_w - 6.0);
let body = box_from_corners([0, 0, 0], [width, length, height]);
let body = body.fillet(6.0, body.edges("|Z"));
let pocket = box_from_corners([wall, wall, floor_t], [width - wall, length - wall, height + 1.0]);
let pocket = pocket.fillet(4.0, pocket.edges("|Z"));
let divider_x = width - wall - trough_w - wall;
let divider = box_from_corners([divider_x, wall - 0.5, floor_t - 0.5], [divider_x + wall, length - wall + 0.5, floor_t + height * 0.45]);
let cx = width - wall - trough_w / 2.0;
let spout = box_from_corners([cx - sw / 2.0 - wall, -10.0, 0], [cx + sw / 2.0 + wall, 1.0, floor_t + 4.0]);
let tray = fuse_all([body - pocket, divider, spout]);
tray - box_from_corners([cx - sw / 2.0, -11.0, floor_t], [cx + sw / 2.0, wall + 0.5, height + 1.0])
