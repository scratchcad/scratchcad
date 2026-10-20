// Desk drawer organiser bin on a 37.5 mm grid: 150 x 75 x 50 mm, 1.8 mm walls with 6 mm outer corner radius, 3 mm rounded inside floor edges, optional cross divider, 2 mm floor
let grid_x = 4; // [1, 8] Length in 37.5 mm grid units
let grid_y = 2; // [1, 6] Width in 37.5 mm grid units
let height = 50.0; // [20.0, 100.0] Bin height (mm)
let wall = 1.8; // [1.2, 3.0] Wall (mm)
let dividers = 1; // [0, 4] Number of cross dividers

const unit = 37.5;
const floor_t = 2.0;
const corner = 6.0;
let l = grid_x * unit - 0.5;
let w = grid_y * unit - 0.5;
let bin = box_from_corners([0, 0, 0], [l, w, height]);
bin = bin.fillet(corner, bin.edges("|Z"));
bin = bin.fillet(1.0, bin.edges("<Z"));
// keep every cell at least 14 mm long
let nd = max(0, min(dividers, ((l - 2.0 * wall) / 14.0).to_int() - 1));
let n = nd + 1;
let cell = (l - 2.0 * wall - nd * wall) / n;
let pockets = [];
for i in 0..n {
    let x0 = wall + i * (cell + wall);
    let p = box_from_corners([x0, wall, floor_t], [x0 + cell, w - wall, height + 5.0]);
    p = p.fillet(corner - wall, p.edges("|Z"));
    p = p.fillet(min(3.0, corner - wall - 1.0), p.edges("<Z"));
    pockets.push(p);
}
bin - compound(pockets)
